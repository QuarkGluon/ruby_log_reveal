require 'net/https'

module RubyLogReveal
  module Client
    class HTTP

      class LogHTTP

        URL_EXCEPTIONS = [
	  Errno::EPIPE, Errno::ECONNRESET, Errno::ETIMEDOUT,
	  Errno::ECONNREFUSED, EOFError, TimeoutError, 
	  OpenSSL::SSL::SSLError
	]

	MAX_RETRIES = 3

	def initialize(input_uri, options={})
	  @input_uri = input_uri
          @verify_mode = options[:verify_mode] || OpenSSL::SSL::VERIFY_PEER
          @ca_file = options[:ca_file]
          @read_timeout = options[:read_timeout] || 2
          @open_timeout = options[:open_timeout] || 2
          @failsafe = options[:failsafe] || $stderr
          @headers = {}
          connect!
	end

	def send_log(log_msg)
	  num_retries = 0

	  begin
	    @http.request_post(@input_uri.path, log_msg, @headers)
	  rescue *URL_EXCEPTIONS => e
	    if num_retries < MAX_RETRIES
	      num_retries += 1
	      rescue_retry(e, log_msg, num_retries)
	      sleep num_retries
	      connect!
	      retry
	    else
	      rescue_errors(e, log_msg)
	    end
	  rescue Exception => e
	    rescue_errors(e, log_msg)
	  end
	end

	private

	def connect!
	  @http = Net::HTTP.new(@input_uri.host, @input_uri.port)
	  @http.use_ssl = true
	  @http.verify_mode = @verify_mode
	  @http.ca_file = @ca_file if @ca_file
	  @http.start unless RUBY_VERSION == "1.8.6"
	  @http.read_timeout = @read_timeout
	  @http.open_timeout = @open_timeout
	end

	def rescue_retry(exception, msg, num_retries)
	  @failsafe.puts "Warning: #{num_retries}/#{MAX_RETRIES} retries. " + rescue_message(exception, msg)
	end

	def rescue_errors(exception, msg)
	  @failsafe.puts 'Error: ' + rescue_message(exception, msg)
	end

	def rescue_message(exception, msg)
          "Got #{exception.class}: #{exception.message} while attempting to post log: #{msg}"
        end
      end

    end
  end
end