module Apacify
  class Titleizer
    PUNCTUATION = /[.!?:—()\[\]]/
    SEPARATOR = /((?:\s|#{PUNCTUATION})+)/

    def initialize(string, ignore: [])
      @string = string
      @ignore = Array(ignore).map { it.to_s.gsub(PUNCTUATION, "") }
    end

    def titleize
      @starts_clause = true
      @string.strip.split(SEPARATOR).map { titleize_token(it) }.join
    end

    private

    def titleize_token(token)
      if separator?(token)
        @starts_clause ||= token.match?(PUNCTUATION)
        token
      else
        titleize_word(token).tap { @starts_clause = false }
      end
    end

    def separator?(token)
      token.strip.empty? || token.match?(PUNCTUATION)
    end

    def titleize_word(token)
      return token if @ignore.include?(token)

      word = Word.new(token)
      (@starts_clause || !word.minor?) ? word.capitalize : token
    end
  end
end
