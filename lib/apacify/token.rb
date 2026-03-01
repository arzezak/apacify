module Apacify
  class Token
    attr_reader :string, :index

    def initialize(string, index)
      @string = string
      @index = index
    end

    def capitalize_word_parts
      parts = string.split("-", -1)
      after_prefix = false
      parts.map! do |part|
        word = part[/\w+/]
        unless word
          after_prefix = false
          next part
        end

        prefix = part[0, part.index(word)]
        suffix = part[(prefix.length + word.length)..]

        capitalized = if all_caps?(word)
          word
        elsif roman_numeral?(word)
          word.upcase
        elsif after_prefix
          word.downcase
        else
          word.downcase.capitalize
        end

        after_prefix ||= PREFIXES.include?(word.downcase)

        "#{prefix}#{capitalized}#{suffix}"
      end
      parts.join("-")
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
      string.match?(/\A(?:\s|#{PUNCTUATION_CHARS})+\s*\z/o)
    end

    private

    def all_caps?(word)
      word.match?(/\A[A-Z]+\z/)
    end

    def roman_numeral?(word)
      word.match?(/\A(?:M{0,4}(?:CM|CD|D?C{0,3})(?:XC|XL|L?X{0,3})(?:IX|IV|V?I{0,3}))\z/i)
    end
  end
end
