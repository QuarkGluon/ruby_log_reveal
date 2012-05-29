require File.join(File.dirname(__FILE__), 'ruby_log_reveal', 'client')
require 'logger'

module RubyLogReveal

  class RequiredInputURL < ArgumentError; end

  def self.new(input_url, options={})
    client = RubyLogReveal::Client.new(input_url, options)
    logger = Logger.new(client)
    logger.formatter = client.formatter
    logger
  end

end