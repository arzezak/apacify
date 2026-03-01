module Apacify
  class Tokenizer
    include Enumerable

    def initialize(string)
      @tokens = string
        .split(WORD_BOUNDARY_PATTERN)
        .map.with_index { |str, index| Token.new(str, index) }

      @tokens.each_cons(2) do |prev, token|
        token.after_punctuation = prev.sentence_ending_punctuation?
      end
    end

    def each(&block)
      return enum_for(:each) unless block_given?

      @tokens.each(&block)
    end
  end
end
