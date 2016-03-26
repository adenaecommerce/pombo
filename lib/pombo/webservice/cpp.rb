module Pombo
  module Webservice
    # Webservice para cálculo de preço e prazo de encomendas
    class CPP
      PROTOCOL = 'http'
      HOST     = 'ws.correios.com.br'
      RESOURCE = "calculador/CalcPrecoPrazo.asmx"
      URL      = "#{ PROTOCOL }://#{ HOST }"
      URI      = "#{ URL }/#{ URI }"
      TIMEOUT  = 5
    end
  end
end
