module Pombo
  class Configuration
    @@default = {
      contract_code: nil,
      password: nil,
      extends_delivery: 0,
      log_level: :info,
      logger: :logger,
      request_timeout: 5
    }

    attr_accessor :contract_code, :password, :extends_delivery, :log_level, :logger, :request_timeout

    def initialize(**args)
      args.each { |key, value| __send__("#{ key }=", value) }
    end

    # Saves the current state of the standard as an object
    # @return [Hash] The new default settings
    def set_default
      attributes = {}
      instance_variables.each{ |v| attributes[v.to_s.delete('@').to_sym] = instance_variable_get(v) }
      @@default.merge!(attributes)
    end

    # Inform settings for persisting with default
    # @see Pombo.setup
    def self.setup(&block)
      if block_given?
        config = new
        block.call config
        config.set_default
      else
        raise Pombo::ConfigurationError, 'expected block the .setup'
      end
    end

    # @return [Hash] The settings that are set as default
    def self.default
      @@default
    end

  end
end
