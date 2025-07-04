require_relative "apalize/error"
require_relative "apalize/titleizer"
require_relative "apalize/token"
require_relative "apalize/version"

module Apalize
  def self.titleize(string)
    Titleizer.new(string).titleize
  end
end

class String
  def apalize
    Apalize.titleize(self)
  end
end
