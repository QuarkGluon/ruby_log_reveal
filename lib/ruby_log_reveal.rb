require 'logger'
require './lib/ruby_log_reveal/client'

module RubyLogReveal

  class RequiredInputURL < ArgumentError; end

  def self.new(input_url, options={})
    client = RubyLogReveal::Client.new(input_url, options)
    logger = Logger.new(client)
    logger.formatter = client.formatter
    logger
  end

end