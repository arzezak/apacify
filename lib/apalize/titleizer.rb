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
      result = []
      capitalize_next = true

      words.each_with_index do |word, index|
        if whitespace_or_punctuation?(word)
          result << word
          capitalize_next = true if sentence_ending_punctuation?(word)
        else
          clean_word = clean_word_for_comparison(word)

          result << if should_capitalize?(capitalize_next, index, words.length, clean_word)
            capitalize_word_parts(word)
          else
            word.downcase
          end

          capitalize_next = false
        end
      end

      result.join("").strip
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

    def should_capitalize?(capitalize_next, index, total_words, clean_word)
      capitalize_next ||
        first_word?(index) ||
        last_word?(index, total_words) ||
        long_word?(clean_word) ||
        !minor_word?(clean_word)
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
