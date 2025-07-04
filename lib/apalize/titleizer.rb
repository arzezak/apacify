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
      words.map.with_index do |word, index|
        if whitespace_or_punctuation?(word)
          word
        else
          clean_word = clean_word_for_comparison(word)
          previous_word = (index > 0) ? words[index - 1] : nil

          if should_capitalize?(index, words.length, clean_word, previous_word)
            capitalize_word_parts(word)
          else
            word.downcase
          end
        end
      end.join("").strip
    end

    private

    def word_boundary_pattern
      /(\s+|[.!?:—()]+\s*)/
    end

    def words
      string.split(word_boundary_pattern)
    end

    # More

    def whitespace_or_punctuation?(word)
      word.match?(/\s+|[.!?:—()]+\s*/)
    end

    def sentence_ending_punctuation?(word)
      word.match?(/[.!?:—()]+\s*/)
    end

    def clean_word_for_comparison(word)
      word.downcase.gsub(/[^\w']/, "")
    end

    def should_capitalize?(index, total_words, clean_word, previous_word)
      first_word?(index) ||
        last_word?(index, total_words) ||
        long_word?(clean_word) ||
        !minor_word?(clean_word) ||
        follows_sentence_ending_punctuation?(previous_word)
    end

    def follows_sentence_ending_punctuation?(previous_word)
      previous_word && sentence_ending_punctuation?(previous_word)
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

    def capitalize_word_parts(word)
      word.gsub(/(^|-)(\w)/) { |match| $1 + $2.upcase }
    end
  end
end
