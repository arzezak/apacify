require "yaml"

module Apacify
  class Titleizer
    attr_reader :tokens, :ignore

    def initialize(string, ignore: [])
      @tokens = Tokenizer.new(string)
      @ignore = wrap(ignore).reject(&:empty?)
    end

    def titleize
      tokens.map do |token|
        if token.in?(ignore)
          token
        elsif should_capitalize?(token)
          token.capitalize_word_parts
        else
          token
        end
      end.join.strip
    end

    private

    def should_capitalize?(token)
      return false if ignored_word?(token)

      token.first? ||
        tokens.previous_punctuation(token)&.sentence_ending_punctuation? ||
        !token.minor_word? ||
        token.long?
    end

    def ignored_word?(token)
      return false if ignore.empty?
      return false if token.whitespace_or_punctuation?

      token_string = token.string.strip

      ignore.any? do |ignore_word|
        # Case-sensitive direct match with full token string
        if token_string == ignore_word
          return true
        end

        # Check if ignore_word contains punctuation and token matches the word part (case-sensitive)
        if ignore_word.match?(/[.!?:—()]/)
          word_part = ignore_word.gsub(/[.!?:—()]+/, "")
          if token_string == word_part
            return true
          end
        end

        false
      end
    end

    def wrap(object)
      case object
      when nil
        []
      when Array
        object.map(&:to_s)
      else
        [object]
      end
    end
  end
end
