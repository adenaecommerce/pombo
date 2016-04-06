module Pombo
  class Error < StandardError; end

  class ConfigurationError < Pombo::Error; end

  class WebserviceError < Pombo::Error; end
end
