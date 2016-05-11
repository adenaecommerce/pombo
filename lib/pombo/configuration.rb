module Pombo
  # It allows you to modify the settings of Pombo
  # @!attribute [rw] contract_code
  #   Its administrative code by the ECT
  # @!attribute [rw] password
  #   Password to access the service, associated with its contract code
  # @!attribute [rw] extends_delivery
  #   Days late on a package
  # @!attribute [rw] request_timeout
  #   Second delay when accessing the webservice
  # @!attribute [rw] log_level
  #   Log Level, `:info`, `:debug` or `warn`
  # @!attribute [rw] logger
  #   Object to trigger messages (defaults to +Logger+)
  # @!attribute [rw] locale
  #   Tells you what language will be used (defaults to `pt-BR`)
  class Configuration
    @@default = {
      contract_code: nil,
      password: nil,
      extends_delivery: 0,
      log_level: :info,
      logger: :logger,
      request_timeout: 5,
      locale: 'pt-BR'
    }

    attr_accessor :contract_code, :password, :extends_delivery, :log_level, :logger, :request_timeout, :locale

    def initialize(**args)
      args = @@default.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }

      I18n.locale = locale
    end

    # Saves the current state of the standard as an object
    # @return [Pombo::Configuration] with default settings
    def set_default
      attributes = {}
      instance_variables.each{ |v| attributes[v.to_s.delete('@').to_sym] = instance_variable_get(v) }
      @@default.merge!(attributes)
      self
    end

    # Inform settings for persisting with default
    # @see Pombo::Configuration
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
