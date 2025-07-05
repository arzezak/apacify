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
        else
          previous_word = (token.index > 0) ? tokens[token.index - 1] : nil

          if should_capitalize?(token, tokens, previous_word)
            token.capitalize_word_parts
          else
            token.downcase
          end
        end
      end.join.strip
    end

    private

    def tokens
      Tokenizer.new(string)
    end

    def should_capitalize?(token, tokens, previous_word)
      tokens.first?(token) ||
        tokens.last?(token) ||
        token.long? ||
        !token.minor_word? ||
        follows_sentence_ending_punctuation?(previous_word)
    end

    def follows_sentence_ending_punctuation?(previous_word)
      previous_word&.sentence_ending_punctuation?
    end
  end
end
