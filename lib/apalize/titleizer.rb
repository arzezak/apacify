require "yaml"

module Apalize
  class Titleizer
    MINOR_WORDS = YAML.safe_load_file(
      File.join(__dir__, "..", "..", "config", "words.yml")
    ).fetch("minor").freeze

    attr_reader :string

    def initialize(string)
      @string = string
    end

    def titleize
      tokens.map do |token|
        if token.whitespace_or_punctuation?
          token
        else
          previous_word = (token.index > 0) ? tokens[token.index - 1] : nil

          if should_capitalize?(token, tokens, previous_word)
            token.capitalize_word_parts
          else
            token.downcase
          end
        end
      end.join.strip
    end

    private

    def tokens
      Tokenizer.new(string)
    end

    def should_capitalize?(token, tokens, previous_word)
      first_word?(token.index) ||
        last_word?(token.index, tokens.count) ||
        long_word?(token.clean_word_for_comparison) ||
        !minor_word?(token.clean_word_for_comparison) ||
        follows_sentence_ending_punctuation?(previous_word)
    end

    def follows_sentence_ending_punctuation?(previous_word)
      previous_word&.sentence_ending_punctuation?
    end

    def first_word?(index)
      index == 0
    end

    def last_word?(index, total_words)
      index == total_words - 1
    end

    def long_word?(clean_word)
      clean_word.length >= 4
    end

    def minor_word?(clean_word)
      MINOR_WORDS.include?(clean_word)
    end
  end
end
