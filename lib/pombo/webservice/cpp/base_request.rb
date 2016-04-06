require 'uri'

module Pombo
  module Webservice
    class CPP
      class BaseRequest

        def initialize(package)
          @package = package
        end

        def to_param
          URI.encode_www_form to_hash
        end
      end
    end
  end
end
