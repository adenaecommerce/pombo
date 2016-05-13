require 'logger'

module Pombo
  # Used to extend the Logger class and customize the message
  # @exemple
  #   Pombo.logger.info('event.namespace'){ 'Any error message' }
  #   # => 2016-05-13 15:15:49 -0300 | POMBO | event.namespace | INFO: Any error message
  class Logger < ::Logger

    private

    def format_message(severity, datetime, progname, msg)
      "#{ datetime } | POMBO | #{ progname } | #{ severity }: #{ msg }"
    end

  end
end
