module Apalize
  class Tokenizer
    include Enumerable

    attr_reader :tokens

    def initialize(string)
      @tokens = string
        .split(word_boundary_pattern)
        .map
        .with_index(&instantiate)
    end

    def [](index)
      tokens[index]
    end

    def each(&block)
      return enum_for(:each) unless block_given?

      tokens.each(&block)
    end

    def previous(token)
      tokens[token.index - 1]
    end

    private

    def instantiate
      ->(token, index) { Token.new(token, index) }
    end

    def word_boundary_pattern
      /(\s+|[.!?:—()]+\s*)/
    end
  end
end
