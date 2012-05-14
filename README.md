RubyLogReveal
=============

Ruby Log Reveal allows log messages to be sent to LogReveal (http://logrevealhq.com) using the HTTPS API.

It can be used instead of the default Ruby Logger and will return an instance of Logger.

Usage
-----

RubyLogReveal can send either a string, with severity:

    require 'ruby_log_reveal'
    log = RubyLogReveal.new(<LOGREVEAL_LOGSTREAM_INPUT_URL>)
    log.warn("Your Ruby application warning message")

Or it can utilise a hash for key/value pair logging, again with severity:

    log.error({ :user_id => 23, :username => "johnsmith", :web_page => "/blog/how-to-build-a-logging-system", :message => "Blog object not found." })


### RubyLogReveal and Ruby on Rails

In the 'config/environments/production.rb'

    RailsApplication::Application.configure do
      config.logger = RubyLogReveal.new(<LOGREVEAL_LOGSTREAM_INPUT_URL>)
    end

Bugs
-----

https://github.com/QuarkGluon/ruby_log_reveal/issues

Pull requests welcome

