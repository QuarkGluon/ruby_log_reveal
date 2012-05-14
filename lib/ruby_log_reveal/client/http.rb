require 'uri'
require './lib/ruby_log_reveal/client/http/loghttp'

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

      def write(log_msg)
        @log_sender.send_log(log_msg)
      end

      def close
        nil
      end
    end
  end
end

