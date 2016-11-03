require 'uri'
require 'net/http'

module Pombo
  module Webservice
    # Class contains the base to make requests
    # @abstract
    class Base

      def self.get(url, request = nil)
        Pombo.logger.info('start_request.webservice') { "GET request: #{ url } - Params: #{ request && request.to_hash.merge(sDsSenha: '****') }" }
        uri = URI.parse url
        uri.query = request.to_param unless request.nil?
        http_request = Net::HTTP::Get.new uri
        http http_request, uri.host, uri.port
      rescue TypeError
        raise WebserviceError, "can't solve the given URL"
      rescue NoMethodError
        raise WebserviceError, "can't parameterize the data provided"
      end

      private

      def self.http(http_request, host, port)
        http = Net::HTTP.new host, port
        #http.set_debug_output($stdout)
        http.open_timeout = Pombo.configurations.request_timeout
        response = http.request(http_request)
        Pombo.logger.info('end_request.webservice') { "GET #{ response.code } response: #{ response.body }" }
        response
      end
    end
  end
end
