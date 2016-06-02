require 'sax-machine'

module Pombo
  module Webservice
    class CPP
      # Response standard for service delivery
      # @!method [rw] code
      #   @return [String]
      # @!method [rw] value
      #   @return [Float]
      # @!method [rw] delivery_time
      #   @return [Fixnum]
      # @!method [rw] value_in_hand
      #   @return [Float]
      # @!method [rw] value_delivery_notice
      #   @return [Float]
      # @!method [rw] value_declared_value
      #   @return [Float]
      # @!method [rw] value_without_additions
      #   @return [Float]
      # @!method [rw] delivery_home
      #   @return [Boolean]
      # @!method [rw] delivery_sartuday
      #   @return [Boolean]
      # @!method [rw] error_code
      #   @return [String]
      # @!method [rw] error_message
      #   @return [String]
      # @!method [rw] comments
      #   @return [String]
      class ServiceResponse
        include SAXMachine

        element :Codigo, as: :code
        element :Valor, as: :value do |value|
          Pombo::Support.str_real_to_float value
        end
        element :PrazoEntrega, as: :delivery_time do |value|
          value.to_i
        end
        element :ValorMaoPropria, as: :value_in_hand do |value|
          Pombo::Support.str_real_to_float value
        end
        element :ValorAvisoRecebimento, as: :value_delivery_notice do |value|
          Pombo::Support.str_real_to_float value
        end
        element :ValorValorDeclarado, as: :value_declared_value do |value|
          Pombo::Support.str_real_to_float value
        end
        element :ValorSemAdicionais, as: :value_without_additions do |value|
          Pombo::Support.str_real_to_float value
        end
        element :EntregaDomiciliar, as: 'delivery_home' do |value|
          value == 'S'
        end
        element :EntregaSabado, as: :delivery_sartuday do |value|
          value == 'S'
        end
        element :Erro, as: :error_code, default: '0'
        element :MsgErro, as: :error_message do
          Pombo.t "webservices.cpp.errors.#{ error_code }"
        end
        element :obsFim, as: :comments
      end
    end
  end
end
