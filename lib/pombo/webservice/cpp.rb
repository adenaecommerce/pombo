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
        url = "#{ URL }/CalcPrazo"
        response = Response.new get(url, DeliveryTimeRequest.new(package))
        response.body
      end

      def self.shipping_value(package)
        url = "#{ URL }/CalcPreco"
        response = Response.new get(url, ShippingValueRequest.new(package))
        response.body
      end
    end
  end
end
