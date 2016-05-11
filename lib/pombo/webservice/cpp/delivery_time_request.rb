require 'uri'

module Pombo
  module Webservice
    class CPP
      # Request for delivery time service
      class DeliveryTimeRequest < BaseRequest
        # Convert the object to the format accepted in webservice Correios
        def to_hash
          {
            nCdServico: @package.services.join(','),
            sCepOrigem: @package.origin_zip_code,
            sCepDestino: @package.destination_zip_code,
          }
        end

      end
    end
  end
end
