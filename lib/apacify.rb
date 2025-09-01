require_relative "apacify/error"
require_relative "apacify/titleizer"
require_relative "apacify/token"
require_relative "apacify/tokenizer"
require_relative "apacify/version"

module Apacify
  MINOR_WORDS = YAML.safe_load_file(
    File.join(__dir__, "..", "config", "minor.yml")
  ).freeze

  PUNCTUATION_CHARS = '[.!?:—()\[\]]'
  PUNCTUATION_PATTERN = /#{PUNCTUATION_CHARS}+\s*/
  WORD_BOUNDARY_PATTERN = /(\s+|#{PUNCTUATION_CHARS}+\s*)/

  def self.titleize(string, ignore: [])
    Titleizer.new(string, ignore:).titleize
  end
end

class String
  def apacify(ignore: [])
    Apacify.titleize(self, ignore:)
  end
end
