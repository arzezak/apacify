require_relative "apacify/titleizer"
require_relative "apacify/version"
require_relative "apacify/word"

module Apacify
  def self.titleize(string, ignore: [])
    Titleizer.new(string, ignore:).titleize
  end
end

class String
  def apacify(ignore: [])
    Apacify.titleize(self, ignore:)
  end
end
