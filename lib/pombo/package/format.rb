module Pombo
  class Package
    # The formats are pre-defined objects with the information provided by the Correios
    module Format
      # List all formats supported by delivery services
      # @return [Array<OpenStruct>] with the data structure representing a format
      #
      # @example
      #     Pombo::Package::Format.all
      #     # => [
      #     # =>    #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
      #     # =>    ....
      #     # => ]
      #
      def self.all
        [
          OpenStruct.new(code: 1, name: Pombo.t('formats.1'), max_length: 105, min_length: 16, max_height: 105, min_height: 2, max_width: 105, min_width: 11, max_dimension: 200),
          OpenStruct.new(code: 2, name: Pombo.t('formats.2'), max_length: 105, min_length: 18, max_diameter: 91, min_diameter: 5, max_dimension: 200),
          OpenStruct.new(code: 3, name: Pombo.t('formats.3'), max_length: 60, min_length: 16, max_width: 60, min_width: 11, max_weight: 1),
        ]
      end

      # Find a specific format by code or by name
      # @return [OpenStruct] the data structure representing a format
      # @param code [String] code or the format name, to box `1, box or package`, to roll `2, roll or prism` and to envelope `3 or envelope`
      # @example
      #     Pombo::Package::Format.find '3'
      #     # => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
      #
      #     # => Or
      #
      #     Pombo::Package::Format.find 'envelope'
      #     # => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
      def self.find(code)
        case code.to_s
        when '1', 'box', 'package'
          all[0]
        when '2', 'roll', 'prism'
          all[1]
        when '3', 'envelope'
          all[2]
        end
      end
    end
  end
end
