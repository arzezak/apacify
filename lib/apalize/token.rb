require "forwardable"

module Apalize
  class Token
    extend Forwardable

    attr_reader :string

    def initialize(string)
      @string = string
    end

    def_delegator :string, :downcase

    def capitalize_word_parts
      string.gsub(/(^|-)(\w)/) { |match| $1 + $2.upcase }
    end

    def clean_word_for_comparison
      string.downcase.gsub(/[^\w']/, "")
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
