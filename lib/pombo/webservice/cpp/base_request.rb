require 'uri'

module Pombo
  module Webservice
    class CPP
      # @abstract class to create the requests for services
      class BaseRequest

        def initialize(package)
          @package = package
        end

        # Encodes the request for http format
        def to_param
          URI.encode_www_form to_hash
        end
      end
    end
  end
end
