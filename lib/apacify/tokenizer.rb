module Apacify
  class Tokenizer
    include Enumerable

    attr_reader :tokens, :ignore

    def initialize(string)
      @tokens = string
        .split(word_boundary_pattern)
        .map
        .with_index(&instantiate)
    end

    def [](index)
      tokens[index]
    end

    def each(&block)
      return enum_for(:each) unless block_given?

      tokens.each(&block)
    end

    def previous(token)
      index = token.index - 1
      while index >= 0 && tokens[index].whitespace_or_punctuation?
        index -= 1
      end
      tokens[index] if index >= 0
    end

    def previous_punctuation(token)
      index = token.index - 1
      while index >= 0
        prev_token = tokens[index]
        return prev_token if prev_token.sentence_ending_punctuation?
        break unless prev_token.whitespace_or_punctuation?
        index -= 1
      end
      nil
    end

    def inside_parentheses_or_brackets?(token)
      # Look backwards for opening punctuation
      opening_punct = nil
      closing_punct = nil

      # Check backwards for opening punctuation
      (token.index - 1).downto(0) do |i|
        t = tokens[i]
        if t.string.match?(/[(\[]/)
          opening_punct = t.string
          break
        elsif t.string.match?(/[)\]]/)
          closing_punct = t.string
          break
        end
      end

      # Check forwards for closing punctuation
      (token.index + 1).upto(tokens.length - 1) do |i|
        t = tokens[i]
        if t.string.match?(/[)\]]/)
          closing_punct = t.string
          break
        elsif t.string.match?(/[(\[]/)
          # Found another opening before closing, so we're not inside
          return false
        end
      end

      # We're inside if we found opening punct before us and closing punct after us
      opening_punct && closing_punct
    end

    private

    def instantiate
      ->(token, index) { Token.new(token, index) }
    end

    def word_boundary_pattern
      /(\s+|[.!?:—()\[\]]+\s*)/
    end
  end
end
