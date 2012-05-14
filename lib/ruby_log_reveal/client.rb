require 'uri'
require './lib/ruby_log_reveal/client/http'

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

      RubyLogReveal::Client::HTTP.new(input_uri, options)
    end

    def stringify_hash(hash)
      hash.map do |v|
        if v[1].is_a?(Hash)
          stringify_hash(v[1])
        else
	  "#{v[0]}=" << case v[1]
	  when Symbol
            v[1].to_s
	  else
	    v[1].inspect
	  end
        end
      end.join(", ")
    end

    def message_create(severity, msg)
      out_msg = ""
      out_msg << "severity=#{severity}, "
      case msg
      when Hash
        out_msg << stringify_hash(msg)
      when String
        out_msg << msg
      else
        out_msg << msg.inspect
      end
      out_msg
    end

  end
end