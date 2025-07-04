module Apalize
  class Tokenizer
    include Enumerable

    attr_reader :tokens

    def initialize(text)
      @tokens = text.split(word_boundary_pattern).map.with_index do |token, index|
        Token.new(token, index)
      end
    end

    def [](index)
      tokens[index]
    end

    def each
      tokens.each { |token| yield(token) }
    end

    private

    def word_boundary_pattern
      /(\s+|[.!?:—()]+\s*)/
    end
  end
end
