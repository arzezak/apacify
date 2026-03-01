module Apacify
  class Titleizer
    attr_reader :tokens, :ignore

    def initialize(string, ignore: [])
      @tokens = Tokenizer.new(string)
      @ignore = wrap(ignore).reject(&:empty?)
    end

    def titleize
      tokens.map do |token|
        if should_capitalize?(token)
          token.titleize_word
        else
          token
        end
      end.join.strip
    end

    private

    def should_capitalize?(token)
      return false if ignored_word?(token)

      token.first? || token.after_punctuation? || !token.minor_word? || token.long?
    end

    def ignored_word?(token)
      return false if ignore.empty?
      return false if token.whitespace_or_punctuation?

      token_string = token.string.strip

      ignore.any? { |w| token_string == w || punctuation_word_match?(token_string, w) }
    end

    def punctuation_word_match?(token_string, ignore_word)
      ignore_word.match?(/[.!?:—()]/) && token_string == ignore_word.gsub(/[.!?:—()]+/, "")
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
