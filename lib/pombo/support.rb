module Pombo
  # Generic methods
  module Support
    TRUE_VALUES  = [true, 1, '1', 't', 'T', 'true', 'TRUE']
    FALSE_VALUES = [false, 0, '0', 'f', 'F', 'false', 'FALSE']

    # Convert the string of Brazilian currency to float
    # @return [String] the converted string pattern R$ (unit brazilian) to pattern Float.
    # @raise [TypeError] if the value is not a String
    # @example
    #   Pombo::Support.str_real_to_float('2,00')
    #   # => '2.00'
    def self.str_real_to_float(value)
      raise TypeError, "no implicit conversion of #{ value.class.name } into String" unless value.kind_of? String
      value.tr('.','').tr(',','.').to_f
    end

    # Used to convert Boolean values to String
    # @param [Boolean] the value to be converted
    # @return [String] the string representation of a boolean. 'S' to +true+ and 'N' to +false+
    # @example
    #   Pombo::Support.boolean_to_string(true)
    #   # => 'S'
    def self.boolean_to_string(value)
      value ? 'S' : 'N'
    end
  end
end
