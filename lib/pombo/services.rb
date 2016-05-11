require 'ostruct'

module Pombo
  # Contains delivery services
  module Services
    # List all services supported
    # @param service [Symbol] group services, `:pac`, `sedex` or `e_sedex`
    # @return [Array<OpenStruct>] with the data structure representing a service
    #
    # @example
    #     Pombo::Services.all
    #     # => [
    #     # =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">,
    #     # =>    ....
    #     # => ]
    #
    # Listing all the services of a group
    #
    # @example
    #     Pombo::Services.all :pac
    #     # => [
    #     # =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">,
    #     # =>    ....
    #     # => ]
    #
    def self.all(service = nil)
      case service
      when :pac
        all_pac.values
      when :sedex
        all_sedex.values
      when :e_sedex
        all_e_sedex.values
      else
        all_pac.values + all_sedex.values + all_e_sedex.values
      end
    end

    # Search for a service code
    # @return [OpenStruct] the data structure representing a service
    # @example
    #     Pombo::Services.find "41106"
    #     # => #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">
    def self.find(code)
      all_services.values_at(code).first
    end

    private

    def self.all_pac
      {
        "41106" => OpenStruct.new(code: "41106", max_weight: 30, name: 'PAC', description: I18n.t('services.pac.41106')),
        "41068" => OpenStruct.new(code: "41068", max_weight: 50, name: 'PAC', description: I18n.t('services.pac.41068')),
        "41300" => OpenStruct.new(code: "41300", max_weight: 600, name: 'PAC GF', description: I18n.t('services.pac.41300'))
      }
    end

    def self.all_sedex
      {
        "40010" => OpenStruct.new(code: "40010", max_weight: 30, name: 'SEDEX', description: I18n.t('services.sedex.40010')),
        "40045" => OpenStruct.new(code: "40045", max_weight: 30, name: 'SEDEX a cobrar', description: I18n.t('services.sedex.40045')),
        "40126" => OpenStruct.new(code: "40126", max_weight: 30, name: 'SEDEX a cobrar', description: I18n.t('services.sedex.40126')),
        "40215" => OpenStruct.new(code: "40215", max_weight: 10, name: 'SEDEX 10', description: I18n.t('services.sedex.40215')),
        "40290" => OpenStruct.new(code: "40290", max_weight: 10, name: 'SEDEX hoje', description: I18n.t('services.sedex.40290')),
        "40096" => OpenStruct.new(code: "40096", max_weight: 30, name: 'SEDEX', description: I18n.t('services.sedex.40096')),
        "40436" => OpenStruct.new(code: "40436", max_weight: 30, name: 'SEDEX', description: I18n.t('services.sedex.40436')),
        "40444" => OpenStruct.new(code: "40444", max_weight: 30, name: 'SEDEX', description: I18n.t('services.sedex.40444')),
        "40568" => OpenStruct.new(code: "40568", max_weight: 30, name: 'SEDEX', description: I18n.t('services.sedex.40568')),
        "40606" => OpenStruct.new(code: "40606", max_weight: 30, name: 'SEDEX', description: I18n.t('services.sedex.40606'))
      }
    end

    def self.all_e_sedex
      {
        "81019" => OpenStruct.new(code: "81019", max_weight: 15, name: 'E-SEDEX', description: I18n.t('services.e_sedex.81019')),
        "81027" => OpenStruct.new(code: "81027", max_weight: 15, name: 'E-SEDEX', description: I18n.t('services.e_sedex.81027')),
        "81035" => OpenStruct.new(code: "81035", max_weight: 15, name: 'E-SEDEX', description: I18n.t('services.e_sedex.81035')),
        "81868" => OpenStruct.new(code: "81868", max_weight: 15, name: 'E-SEDEX', description: I18n.t('services.e_sedex.81868')),
        "81833" => OpenStruct.new(code: "81833", max_weight: 15, name: 'E-SEDEX', description: I18n.t('services.e_sedex.81833')),
        "81850" => OpenStruct.new(code: "81850", max_weight: 15, name: 'E-SEDEX', description: I18n.t('services.e_sedex.81850'))
      }
    end

    def self.all_services
      all_pac.merge(all_sedex).merge(all_e_sedex)
    end
  end
end
