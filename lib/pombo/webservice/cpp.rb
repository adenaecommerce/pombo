module Pombo
  module Webservice
    # Webservice for price calculation and calculation period packages
    class CPP < Base
      PROTOCOL = 'http'
      HOST     = 'ws.correios.com.br'
      URL      = "#{ PROTOCOL }://#{ HOST }/calculador/CalcPrecoPrazo.asmx"

      def self.shipping(package)
        url = "#{ URL }/CalcPrecoPrazo"
        response = Response.new get(url, ShippingRequest.new(package))
        response.body
      end

      def self.delivery_time(package)
      end

      def self.shipping_value(service_code, package)
      end
    end
  end
end
