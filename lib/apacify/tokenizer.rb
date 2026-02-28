module Apacify
  class Tokenizer
    include Enumerable

    attr_reader :tokens

    def initialize(string)
      @tokens = string
        .split(word_boundary_pattern)
        .map
        .with_index { |token, index| Token.new(token, index) }
    end

    def [](index)
      tokens[index]
    end

    def each(&block)
      return enum_for(:each) unless block_given?

      tokens.each(&block)
    end

    def previous_punctuation(token)
      index = token.index - 1
      while index >= 0
        prev_token = tokens[index]
        return prev_token if prev_token.sentence_ending_punctuation?
        break unless prev_token.whitespace_or_punctuation?
        index -= 1
      end
      nil
    end

    private

    def word_boundary_pattern
      WORD_BOUNDARY_PATTERN
    end
  end
end
