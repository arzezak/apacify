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
      string.gsub(/(^|-)(\w)/) { |match| $1 + $2.upcase }
    end

    def first?
      index == 0
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
      string.match?(/[.!?:—()]+\s*/)
    end

    def to_s
      string
    end

    def whitespace_or_punctuation?
      string.match?(/\s+|[.!?:—()]+\s*/)
    end
  end
end
