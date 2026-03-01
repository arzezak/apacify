require_relative "apacify/titleizer"
require_relative "apacify/token"
require_relative "apacify/tokenizer"
require_relative "apacify/version"

module Apacify
  MINOR_WORDS = %w[
    a an and as at but by de for from
    if in nor of off on or out pas per
    so the to up via with yet
  ].freeze

  PREFIXES = %w[
    anti co counter ex extra infra inter intra
    macro mega meta micro mid mini multi neo
    non over post pre pro proto pseudo quasi
    re semi sub super supra trans ultra un under
  ].to_set.freeze

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
