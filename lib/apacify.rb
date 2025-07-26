require_relative "apacify/error"
require_relative "apacify/titleizer"
require_relative "apacify/token"
require_relative "apacify/tokenizer"
require_relative "apacify/version"

module Apacify
  MINOR_WORDS = YAML.safe_load_file(
    File.join(__dir__, "..", "config", "minor.yml")
  ).freeze

  def self.titleize(string)
    Titleizer.new(string).titleize
  end
end

class String
  def apacify
    Apacify.titleize(self)
  end
end
