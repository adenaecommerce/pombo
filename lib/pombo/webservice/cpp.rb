module Pombo
  module Webservice
    # Webservice for price calculation and calculation period packages
    class CPP < Base
      PROTOCOL = 'http'
      HOST     = 'ws.correios.com.br'
      URL      = "#{ PROTOCOL }://#{ HOST }/calculador/CalcPrecoPrazo.asmx"

      def self.shipping(package)
        resource "#{ URL }/CalcPrecoPrazo", ShippingRequest.new(package)
      end

      def self.delivery_time(package)
        resource "#{ URL }/CalcPrazo", DeliveryTimeRequest.new(package)
      end

      def self.shipping_value(package)
        resource "#{ URL }/CalcPreco", ShippingValueRequest.new(package)
      end

      private

      def self.resource(url, request)
        response = Response.new get(url, request)
        response.body
      end
    end
  end
end
