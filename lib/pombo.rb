require 'pombo/version'
require 'pombo/configuration'
require 'pombo/exception'

module Pombo
  # Inform settings for persisting with default
  # @yield [config] with the configuration data
  # @option config [String]  :contract_code Its administrative code by the ECT
  # @option config [String]  :password Password to access the service, associated with its contract code
  # @option config [Integer] :extends_delivery Days late on a package
  # @option config [Integer] :request_timeout Second delay when accessing the webservice
  # @option config [Symbol]  :log_level Log Level, `:info`, `:debug` or `warn`
  # @option config [Symbol]  :logger object to trigger messages (defaults to `:logger`)
  #
  # @example
  #   Pombo::Configuration.setup do |config|
  #     config.contract_code = 'AA99BB'
  #     config.password = '999999'
  #     config.extends_delivery = 0
  #     config.request_timeout = 5
  #     config.log_level = :info
  #     config.logger = :logger
  #   end
  def self.setup(&block)
    Configuration.setup(&block)
  end

  def self.configure(**args)

  end

  def self.shipping(service_code, package)
  end

  def self.delivery_time(service_code, package)
  end

  def self.shipping_value(service_code, package)
  end

end
