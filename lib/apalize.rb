require_relative "apalize/error"
require_relative "apalize/titleizer"
require_relative "apalize/token"
require_relative "apalize/tokenizer"
require_relative "apalize/version"

module Apalize
  MINOR_WORDS = YAML.safe_load_file(
    File.join(__dir__, "..", "config", "minor.yml")
  ).freeze

  def self.titleize(string)
    Titleizer.new(string).titleize
  end
end

class String
  def apalize
    Apalize.titleize(self)
  end
end
