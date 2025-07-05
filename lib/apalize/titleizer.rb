require "yaml"

module Apalize
  class Titleizer
    attr_reader :string

    def initialize(string)
      @string = string
    end

    def titleize
      tokens.map do |token|
        if token.whitespace_or_punctuation?
          token
        elsif should_capitalize?(token, tokens)
          token.capitalize_word_parts
        else
          token.downcase
        end
      end.join.strip
    end

    private

    def tokens
      Tokenizer.new(string)
    end

    def should_capitalize?(token, tokens)
      tokens.first?(token) || tokens.last?(token) || token.long? || !token.minor_word? || tokens.previous(token).sentence_ending_punctuation?
    end
  end
end
