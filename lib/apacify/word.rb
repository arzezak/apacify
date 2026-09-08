module Apacify
  class Word
    MINOR = %w[
      a an and as at but by de for if in nor
      of off on or out pas per so the to up via yet
    ].freeze

    PREFIXES = %w[
      anti co counter ex extra infra inter intra
      macro mega meta micro mid mini multi neo
      non over post pre pro proto pseudo quasi
      re semi sub super supra trans ultra un under
    ].freeze

    ROMAN_NUMERAL = /\AM{0,4}(?:CM|CD|D?C{0,3})(?:XC|XL|L?X{0,3})(?:IX|IV|V?I{0,3})\z/i

    def initialize(string)
      @string = string
    end

    def minor?
      MINOR.include?(@string.downcase.gsub(/\W/, ""))
    end

    def capitalize
      parts = @string.split("-", -1)
      prefix_index = parts.index { PREFIXES.include?(it[/\w+/]&.downcase) }

      parts.each_with_index.map do |part, index|
        part.sub(/\w+/) { capitalize_part(it, after_prefix: prefix_index && index > prefix_index) }
      end.join("-")
    end

    private

    def capitalize_part(part, after_prefix:)
      if part.match?(/\A[A-Z]+\z/)
        part
      elsif part.match?(ROMAN_NUMERAL)
        part.upcase
      elsif after_prefix
        part.match?(/\A\p{Upper}/) ? part : part.downcase
      else
        part.capitalize
      end
    end
  end
end
