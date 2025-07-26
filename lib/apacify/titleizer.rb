require "yaml"

module Apacify
  class Titleizer
    attr_reader :tokens

    def initialize(string)
      @tokens = Tokenizer.new(string)
    end

    def titleize
      tokens.map do |token|
        if should_capitalize?(token)
          token.capitalize_word_parts
        else
          token
        end
      end.join.strip
    end

    private

    def should_capitalize?(token)
      token.first? ||
        tokens.previous(token).sentence_ending_punctuation? ||
        !token.minor_word? ||
        token.long?
    end
  end
end
