require 'sax-machine'

module Pombo
  module Webservice
    # Class representing the webservice for consulting services
    class CPP
      # Performs the parse of the server response
      class ParseService
        include SAXMachine
        elements :cServico, as: :services, class: Pombo::Webservice::CPP::ServiceResponse
      end

      # Comes the response from the server
      class Response
        def initialize(http_response)
          @http_response = http_response
        end

        # Contains services found
        # @return [Array<Pombo::Webservice::CPP::ServiceResponse>] the services found
        def body
          response = Pombo::Webservice::CPP::ParseService.parse @http_response.body
          response.services
        end
      end

    end
  end
end
