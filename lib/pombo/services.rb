require 'ostruct'

module Pombo
  module Services
    @@all_pac = {
      "41106" => OpenStruct.new(code: "41106", max_weight: 30, name: 'PAC', description: 'PAC (sem contrato)'),
      "41068" => OpenStruct.new(code: "41068", max_weight: 50, name: 'PAC', description: 'PAC (com contrato)'),
      "41300" => OpenStruct.new(code: "41300", max_weight: 600, name: 'PAC GF', description: 'PAC (grandes formatos)')
    }

    @@all_sedex = {
      "40010" => OpenStruct.new(code: "40010", max_weight: 30, name: 'SEDEX', description: 'SEDEX (sem contrato)'),
      "40045" => OpenStruct.new(code: "40045", max_weight: 30, name: 'SEDEX a cobrar', description: 'SEDEX a cobrar (sem contrato)'),
      "40126" => OpenStruct.new(code: "40126", max_weight: 30, name: 'SEDEX a cobrar', description: 'SEDEX a cobrar (com contrato)'),
      "40215" => OpenStruct.new(code: "40215", max_weight: 10, name: 'SEDEX 10', description: 'SEDEX 10 (sem contrato)'),
      "40290" => OpenStruct.new(code: "40290", max_weight: 10, name: 'SEDEX hoje', description: 'SEDEX hoje (sem contrato)'),
      "40096" => OpenStruct.new(code: "40096", max_weight: 30, name: 'SEDEX', description: 'SEDEX (com contrato)'),
      "40436" => OpenStruct.new(code: "40436", max_weight: 30, name: 'SEDEX', description: 'SEDEX (com contrato)'),
      "40444" => OpenStruct.new(code: "40444", max_weight: 30, name: 'SEDEX', description: 'SEDEX (com contrato)'),
      "40568" => OpenStruct.new(code: "40568", max_weight: 30, name: 'SEDEX', description: 'SEDEX (com contrato)'),
      "40606" => OpenStruct.new(code: "40606", max_weight: 30, name: 'SEDEX', description: 'SEDEX (com contrato)')
    }

    @@all_e_sedex = {
      "81019" => OpenStruct.new(code: "81019", max_weight: 15, name: 'E-SEDEX', description: 'E-SEDEX (com contrato)'),
      "81027" => OpenStruct.new(code: "81027", max_weight: 15, name: 'E-SEDEX', description: 'E-SEDEX Prioritário (com contrato)'),
      "81035" => OpenStruct.new(code: "81035", max_weight: 15, name: 'E-SEDEX', description: 'E-SEDEX Express (com contrato)'),
      "81868" => OpenStruct.new(code: "81868", max_weight: 15, name: 'E-SEDEX', description: 'E-SEDEX (com contrato, grupo 1)'),
      "81833" => OpenStruct.new(code: "81833", max_weight: 15, name: 'E-SEDEX', description: 'E-SEDEX (com contrato, grupo 2)'),
      "81850" => OpenStruct.new(code: "81850", max_weight: 15, name: 'E-SEDEX', description: 'E-SEDEX (com contrato, grupo 3)')
    }

    @@all_services = @@all_pac.merge(@@all_sedex).merge(@@all_e_sedex)

    def self.all(service = nil)
      case service
      when :pac, 'pac'
        @@all_pac.values
      when :sedex, 'sedex'
        @@all_sedex.values
      when :e_sedex, 'e_sedex'
        @@all_e_sedex.values
      else
        @@all_pac.values + @@all_sedex.values + @@all_e_sedex.values
      end
    end

    def self.find(code)
     @@all_services.values_at(code).first
    end
  end
end
