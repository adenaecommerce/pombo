module Pombo
  module Webservice
    # Webservice for price calculation and calculation period packages
    class CPP < Base
      PROTOCOL = 'http'
      HOST     = 'ws.correios.com.br'
      URL      = "#{ PROTOCOL }://#{ HOST }/calculador/CalcPrecoPrazo.asmx"

      def initialize(configurations)
        @configurations = configurations
      end

      def shipping(package)
        response = Response.new get(URL, parse_shipping(package))
        response.body
      end

      def delivery_time(package)
      end

      def shipping_value(service_code, package)
      end

      private

      def parse_shipping(package)
        {
          nCdEmpresa: @configurations.contract_code,
          sDsSenha: @configurations.password,
          nCdServico: package.services.join(','),
          sCepOrigem: package.origin_zip_code,
          sCepDestino: package.destination_zip_code,
          nVlPeso: package.weight,
          nCdFormato: package.format,
          nVlComprimento: package.length,
          nVlAltura: package.height,
          nVlLargura: package.width,
          nVlDiametro: package.diameter,
          sCdMaoPropria: boolean_values(package.in_hand?),
          nVlValorDeclarado: package.declared_value,
          sCdAvisoRecebimento: boolean_values(package.delivery_notice?)
        }
      end

      def parse_delivery_time(package)
      end

      def parse_shipping_value(package)
      end

      def boolean_values(value)
        value ? 'S' : 'N'
      end
    end
  end
end
