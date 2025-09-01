require "forwardable"

module Apacify
  class Token
    extend Forwardable

    attr_reader :string, :index

    def_delegator :string, :downcase

    def initialize(string, index)
      @string = string
      @index = index
    end

    def capitalize_word_parts
      string.downcase.gsub(/(^|-)(\w+)/) do |match|
        prefix = $1
        word = $2
        if roman_numeral?(word)
          prefix + word.upcase
        else
          prefix + word.capitalize
        end
      end
    end

    def first?
      index == 0
    end

    def in?(array)
      array.include?(string)
    end

    def letters
      string.downcase.gsub(/[^\w']/, "")
    end

    def long?
      letters.length >= 4
    end

    def minor_word?
      MINOR_WORDS.include?(letters)
    end

    def sentence_ending_punctuation?
      string.match?(punctuation_pattern)
    end

    def to_s
      string
    end

    def whitespace_or_punctuation?
      string.match?(/\s+/) || sentence_ending_punctuation?
    end

    private

    def punctuation_pattern
      PUNCTUATION_PATTERN
    end

    def roman_numeral?(word)
      # Only letters used in roman numerals
      return false unless word.match?(/\A[ivxlcdm]+\z/)

      # Roman numeral pattern - matches valid combinations
      # This pattern handles: 1-3999 (I-MMMCMXCIX)
      word.match?(/\A(?=[mdclxvi])m{0,4}(cm|cd|d?c{0,3})?(xc|xl|l?x{0,3})?(ix|iv|v?i{0,3})?\z/)
    end
  end
end
