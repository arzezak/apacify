module Apacify
  class Titleizer
    attr_reader :tokens, :ignore

    def initialize(string, ignore: [])
      @tokens = Tokenizer.new(string)
      @ignore = wrap(ignore).reject(&:empty?)
      mark_ignored_tokens
    end

    def titleize
      tokens.map(&:titleize).join.strip
    end

    private

    def mark_ignored_tokens
      return if ignore.empty?

      tokens.each do |token|
        token.ignored = ignored_word?(token)
      end
    end

    def ignored_word?(token)
      return false if token.whitespace_or_punctuation?

      token_string = token.string.strip

      ignore.any? { token_string == it || punctuation_word_match?(token_string, it) }
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
