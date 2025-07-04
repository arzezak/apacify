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
      tokens.map.with_index do |token, index|
        if token.whitespace_or_punctuation?
          token
        else
          clean_word = token.clean_word_for_comparison
          previous_word = (index > 0) ? tokens[index - 1] : nil

          if should_capitalize?(index, tokens.length, clean_word, previous_word)
            token.capitalize_word_parts
          else
            token.downcase
          end
        end
      end.join.strip
    end

    private

    def tokens
      string.split(word_boundary_pattern).map(&Token.method(:new))
    end

    def word_boundary_pattern
      /(\s+|[.!?:—()]+\s*)/
    end

    def should_capitalize?(index, total_words, clean_word, previous_word)
      first_word?(index) ||
        last_word?(index, total_words) ||
        long_word?(clean_word) ||
        !minor_word?(clean_word) ||
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
