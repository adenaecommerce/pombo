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
  # @!attribute [rw] min_package
  #   Force Pombo send at least a package of minimum dimensions of Correios
  # @!attribute [rw] log_level
  #   Level compatible with Ruby Logger
  # @!attribute [rw] logger
  #   Object to trigger messages (defaults to +Pombo::Logger+)
  # @!attribute [rw] locale
  #   Tells you what language will be used (defaults to `pt-BR`)
  class Configuration
    @@default = {
      contract_code: nil,
      password: nil,
      extends_delivery: 0,
      min_package: true,
      log_level: Pombo::Logger::INFO,
      logger: Pombo::Logger.new(STDOUT),
      request_timeout: 5,
      locale: 'pt-BR'
    }

    attr_accessor :contract_code, :password, :extends_delivery, :log_level, :logger, :request_timeout, :locale, :min_package

    def initialize(**args)
      args = @@default.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }

      logger.level = log_level
    end

    # @return [Boolean] tells you if a package with minimum size will be sent
    def min_package?
      Pombo::Support::TRUE_VALUES.include? @min_package
    end

    # Saves the current state of the standard as an object
    # @return [Pombo::Configuration] with default settings
    def set_default
      attributes = {}
      instance_variables.each{ |v| attributes[v.to_s.delete('@').to_sym] = instance_variable_get(v) }
      @@default.merge!(attributes)
      Pombo.logger.info('update.configuration'){ 'Update the default settings' }
      self
    end

    # Inform settings for persisting with default
    # @param [Proc] with the configuration data.
    # @return [Pombo::Configuration] the updated settings
    # @raise [Pombo::ConfigurationError] if not passed a block
    def self.setup
      raise(Pombo::ConfigurationError, 'expected block the .setup') unless block_given?
      config = new
      yield config
      config.set_default
      self
    end

    # @return [Hash] The settings that are set as default
    def self.default
      @@default
    end
  end
end
