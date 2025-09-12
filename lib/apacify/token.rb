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
      result = ""
      match_start = 0

      string.scan(/(^|-)(\w+)/) do |prefix, word|
        match_index = string.index(prefix + word, match_start)
        original_word = string[match_index + prefix.length, word.length]

        result += if all_caps?(original_word)
          prefix + original_word
        elsif roman_numeral?(word)
          prefix + word.upcase
        else
          prefix + word.downcase.capitalize
        end

        match_start = match_index + prefix.length + word.length
      end

      # Handle any remaining characters
      if match_start < string.length
        result += string[match_start..]
      end

      result
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

    def all_caps?(word)
      word.match?(/\A[A-Z]+\z/) && word.length > 0
    end

    def roman_numeral?(word)
      # Match valid Roman numerals (case insensitive)
      # This pattern matches common Roman numerals from I to MMMCMXCIX (3999)
      word.match?(/\A(?=[MDCLXVI])M{0,4}(C[MD]|D?C{0,3})?(X[CL]|L?X{0,3})?(I[XV]|V?I{0,3})?\z/i) && !word.empty?
    end
  end
end
