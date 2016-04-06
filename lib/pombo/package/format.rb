module Pombo
  class Package
    module Format
      @@all_formats = {
        '1' => OpenStruct.new(code: 1, name: 'Caixa/Pacote', max_length: 105, min_length: 16, max_height: 105, min_height: 2, max_width: 105, min_width: 11, max_dimension: 200),
        '2' => OpenStruct.new(code: 2, name: 'Rolo/Prisma', max_length: 105, min_length: 18, max_diameter: 91, min_diameter: 5, max_dimension: 200),
        '3' => OpenStruct.new(code: 3, name: 'Envelope', max_length: 60, min_length: 16, max_width: 60, min_width: 11, max_weight: 1),
      }

      def self.all
        @@all_formats.values
      end

      def self.find(code)
        case code.to_s
        when '1', 'box', 'package'
          @@all_formats.values_at('1').first
        when '2', 'roll', 'prism'
          @@all_formats.values_at('2').first
        when '3', 'envelope'
          @@all_formats.values_at('3').first
        end
      end
    end
  end
end
