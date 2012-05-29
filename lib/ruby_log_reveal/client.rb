require File.join(File.dirname(__FILE__), 'client', 'http')
require 'uri'

module RubyLogReveal
  module Client

    def self.new(input_url, options={})
      unless input_url
        raise RequiredInputURL.new
      end

      options.merge!({ :input_url => input_url })
    
      begin
        input_uri = URI.parse(options[:input_url])
      rescue URI::InvalidURIError => e
        raise RequiredInputURL.new("The input URL #{input_uri} was incorrect")
      end

      RubyLogReveal::Client::HTTP.new(options)
    end

  end
end