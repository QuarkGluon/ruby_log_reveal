RubyLogReveal
=============

Ruby Log Reveal allows log messages to be sent to LogReveal using the HTTPS API.

It can be used instead of the default Ruby Logger and will return an instance of Logger.

Usage
-----

    require 'ruby_log_reveal'

    log = RubyLogReveal.new(<INPUT URL>)

    log.warn("A typical Ruby application warning message")

Or

    log.error({ :user_id => 23, :username => "johnsmith", :web_page => "/blog/how-to-build-a-logging-system", :message => "Blog object not found." })


### With Rails

config/environments/production.rb

    RailsApplication::Application.configure do
      config.logger = RubyLogReveal.new(<INPUT URL>)
    end

Bugs
-----

https://github.com/QuarkGluon/ruby_log_reveal/issues

Pull requests welcome

