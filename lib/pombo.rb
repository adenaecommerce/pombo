require 'i18n'
I18n.load_path += Dir[File.expand_path('../../locales/*.yml', __FILE__)]

require 'pombo/version'
require 'pombo/configuration'
require 'pombo/exception'
require 'pombo/support'
require 'pombo/services'
require 'pombo/package'
require 'pombo/package/item'
require 'pombo/package/format'
require 'pombo/webservice/base'
require 'pombo/webservice/cpp'
require 'pombo/webservice/cpp/service_response'
require 'pombo/webservice/cpp/response'
require 'pombo/webservice/cpp/base_request'
require 'pombo/webservice/cpp/shipping_request'
require 'pombo/webservice/cpp/shipping_value_request'
require 'pombo/webservice/cpp/delivery_time_request'

# It allows you to configure and perform consulting delivery services
#
# For more information read the file {file:/readmes/README-EN.md}
module Pombo
  # Inform settings for persisting with default
  # @yield [config] with the configuration data.
  # @return [Pombo::Configuration]
  def self.setup(&block)
    Configuration.setup(&block)
  end

  # Tells the settings that will be used at this time
  # @note Does not modify the default settings
  # @return [Pombo::Configuration] current settings
  def self.set(**args)
    @@configurations = Configuration.new args
  end

  # @return [Pombo::Configuration] current settings
  def self.configurations
    @@configurations ||= Configuration.new
  end

  # Perform the quotation of delivery of consulting services value and delivery time
  # @param package [Pombo::Package] the package to be consulted
  # @return [Array<Pombo::Webservice::CPP::ServiceResponse>]
  def self.shipping(package)
    Webservice::CPP.shipping(package)
  end

  # Perform the quotation of delivery of consulting delivery time
  # @param package [Pombo::Package] the package to be consulted
  # @return [Array<Pombo::Webservice::CPP::ServiceResponse>]
  def self.delivery_time(package)
    Webservice::CPP.delivery_time(package)
  end

  # Perform the quotation of delivery of consulting services value
  # @param package [Pombo::Package] the package to be consulted
  # @return [Array<Pombo::Webservice::CPP::ServiceResponse>]
  def self.shipping_value(package)
    Webservice::CPP.shipping_value(package)
  end

  # Performs internationalization for informed locale in settings
  # @return [String] internationalized text
  def self.t(*args)
    I18n.with_locale configurations.locale do
      I18n.translate args
    end.first
  end

end
