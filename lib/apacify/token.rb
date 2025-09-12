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
      string.match?(PUNCTUATION_PATTERN)
    end

    def to_s
      string
    end

    def whitespace_or_punctuation?
      string.match?(/\s+/) || sentence_ending_punctuation?
    end

    private

    def all_caps?(word)
      word.match?(/\A[A-Z]+\z/)
    end

    def roman_numeral?(word)
      # Match valid Roman numerals - simplified but accurate pattern
      word.match?(/\A(?:M{0,4}(?:CM|CD|D?C{0,3})(?:XC|XL|L?X{0,3})(?:IX|IV|V?I{0,3}))\z/i)
    end
  end
end
