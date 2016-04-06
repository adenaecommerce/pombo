require 'uri'
require 'net/http'

module Pombo
  module Webservice
    class Base

      def initialize(configurations)
        @configurations = configurations
      end

      def get(url, data={})
        uri = URI.parse url
        uri.query = URI.encode_www_form data
        request = Net::HTTP::Get.new uri
        http request, uri.host, uri.port
      rescue TypeError
        raise WebserviceError, "can't solve the given URL"
      rescue NoMethodError
        raise WebserviceError, "can't parameterize the data provided"
      end

      private

      def http(request, host, port)
        http = Net::HTTP.new host, port
        http.open_timeout = @configurations.request_timeout
        http.request(request)
      end
    end
  end
end
