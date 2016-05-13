module Pombo
  # Generic exception
  class Error < StandardError
    def initializer(msg = nil)
      super

      Pombo.logger.error('exception.pombo') { msg }
    end
  end

  # Exception triggered to manage settings
  class ConfigurationError < Pombo::Error; end

  # Exception triggered when managing the webservice
  class WebserviceError < Pombo::Error; end
end
