require 'uri'
require 'http/loghttp'

module Logglier
  module Client
    class HTTP
      attr_reader :log_sender    

      def initialize(input_uri, options={})
        @log_sender = RubyLogReveal::Client::HTTP::LogHTTP.new(input_uri, options)
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

