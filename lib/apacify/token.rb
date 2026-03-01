module Apacify
  class Token
    attr_reader :string, :index
    attr_writer :after_punctuation, :ignored

    def initialize(string, index)
      @string = string
      @index = index
      @after_punctuation = false
      @ignored = false
    end

    def after_punctuation?
      @after_punctuation
    end

    def ignored?
      @ignored
    end

    def titleize
      should_capitalize? ? titleize_word : string
    end

    def first?
      index == 0
    end

    def letters
      string.downcase.gsub(/[^\w']/, "")
    end

    def long?
      letters.length >= 4
    end

    def minor_word?
      MINOR_WORDS.include?(letters)
    end

    def sentence_ending_punctuation?
      string.match?(PUNCTUATION_PATTERN)
    end

    def to_s
      string
    end

    def whitespace_or_punctuation?
      string.match?(/\A(?:\s|#{PUNCTUATION_CHARS})+\s*\z/o)
    end

    private

    def should_capitalize?
      return false if ignored?

      first? || after_punctuation? || !minor_word? || long?
    end

    def titleize_word
      hyphenated? ? capitalize_hyphenated : capitalize_word
    end

    def hyphenated?
      string.include?("-")
    end

    def capitalize_word
      prefix, word, suffix = string.match(/(\W*)(\w+)(.*)/)&.captures
      return string unless word

      "#{prefix}#{capitalize_part(word, false)}#{suffix}"
    end

    def capitalize_hyphenated
      parts = string.split("-", -1)
      first_prefix = parts.index { |p| PREFIXES.include?(p[/\w+/]&.downcase) }

      parts.each_with_index.map do |part, i|
        prefix, word, suffix = part.match(/(\W*)(\w+)(.*)/)&.captures
        next part unless word

        capitalized = capitalize_part(word, first_prefix && i > first_prefix)
        "#{prefix}#{capitalized}#{suffix}"
      end.join("-")
    end

    def all_caps?(word)
      word.match?(/\A[A-Z]+\z/)
    end

    def capitalize_part(word, after_prefix)
      if all_caps?(word)
        word
      elsif roman_numeral?(word)
        word.upcase
      elsif after_prefix
        capitalized?(word) ? word : word.downcase
      else
        word.downcase.capitalize
      end
    end

    def capitalized?(word)
      word[0] == word[0].upcase
    end

    def roman_numeral?(word)
      word.match?(/\A(?:M{0,4}(?:CM|CD|D?C{0,3})(?:XC|XL|L?X{0,3})(?:IX|IV|V?I{0,3}))\z/i)
    end
  end
end
