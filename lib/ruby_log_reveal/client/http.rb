require File.join(File.dirname(__FILE__), 'http', 'loghttp')
require 'uri'
require 'CGI'

module RubyLogReveal
  module Client
    class HTTP
      attr_reader :input_uri, :log_sender

      def initialize(options={})
        @input_uri = options[:input_url]

        begin
          @input_uri = URI.parse(@input_uri)
        rescue URI::InvalidURIError => e
          raise URLRequired.new("Invalid Input URL: #{@input_uri}")
        end

        @log_sender = RubyLogReveal::Client::HTTP::LogHTTP.new(@input_uri, options)
      end

      def formatter
        proc do |severity, datetime, progname, msg|
	  message = "timestamp=#{CGI.escape(datetime.to_s)}&"
	  message << "severity=#{CGI.escape(severity.to_s)}&"
	  message << "program_name=#{CGI.escape(progname.to_s)}&"
	  case msg
	  when Hash
	    message << msg.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"}.join("&")
	  when String
	    message << "message=#{CGI.escape(msg)}"
	  else
	    message << "message=#{CGI.escape(msg.inspect)}"
	  end	
	  message
        end
      end

      def write(log_msg)
        @log_sender.send_log(log_msg)
      end

      def close
        nil
      end
    end
  end
end

