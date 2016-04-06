require 'uri'

module Pombo
  module Webservice
    class CPP
      class DeliveryTimeRequest < BaseRequest

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
