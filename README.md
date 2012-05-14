RubyLogReveal
=============

Ruby Log Reveal allows log messages to be sent to LogReveal (http://logrevealhq.com) using the HTTPS API.

It can be used instead of the default Ruby Logger and will return an instance of Logger.

Installation
------------

    gem install ruby_log_reveal

Usage
-----

The first step is to obtain a LogReveal LogStream HTTPS input URL. This will be given to you when you create an account at LogReveal. 

To start logging, RubyLogReveal can send either a log message string with severity:

    require 'ruby_log_reveal'
    log = RubyLogReveal.new('<LOGREVEAL_LOGSTREAM_INPUT_URL>')
    log.warn("Your Ruby application warning message")

Or it can utilise a hash for key/value pair logging, again with severity:

    log.error({ :user_id => 23, :username => "johnsmith", :web_page => "/blog/how-to-build-a-logging-system", :message => "Blog object not found." })


### RubyLogReveal and Rails

Ruby Log Reveal will work with Rails or any Ruby web framework (Sinatra, Padrino etc). For Rails specifically:

In the 'config/environments/production.rb'

    RailsApplication::Application.configure do
      config.logger = RubyLogReveal.new('<LOGREVEAL_LOGSTREAM_INPUT_URL>')
    end

Bugs
-----

https://github.com/QuarkGluon/ruby_log_reveal/issues

Pull requests welcome

