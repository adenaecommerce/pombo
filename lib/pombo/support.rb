module Pombo
  # Generic methods
  module Support
    TRUE_VALUES  = [true, 1, '1', 't', 'T', 'true', 'TRUE']
    FALSE_VALUES = [false, 0, '0', 'f', 'F', 'false', 'FALSE']

    # @return [String] the converted string pattern R$ (unit brazilian) to pattern Float. e.g '2,00' to '2.00'
    # @raise [TypeError] if the value is not a String
    def self.str_real_to_float(value)
      raise TypeError, "no implicit conversion of #{ value.class.name } into String" unless value.kind_of? String
      value.tr(',','.').to_f
    end

    # return [String] the string representation of a boolean. 'S' to +true+ and 'N' to +false+
    def self.boolean_to_string(value)
      value ? 'S' : 'N'
    end
  end
end
