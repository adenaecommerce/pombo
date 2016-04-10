require 'sax-machine'

module Pombo
  module Webservice
    class CPP
      class ParseService
        include SAXMachine
        elements :cServico, as: :services, class: Pombo::Webservice::CPP::ServiceResponse
      end

      class Response

        def initialize(http_response)
          @http_response = http_response
        end

        def body
          response = Pombo::Webservice::CPP::ParseService.parse @http_response.body
          response.services
        end
      end

    end
  end
end
