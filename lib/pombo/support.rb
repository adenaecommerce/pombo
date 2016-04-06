module Pombo
  module Support
    TRUE_VALUES  = [true, 1, '1', 't', 'T', 'true', 'TRUE']
    FALSE_VALUES = [false, 0, '0', 'f', 'F', 'false', 'FALSE']

    def self.str_real_to_float(value)
      raise TypeError, "no implicit conversion of #{ value.class.name } into String" unless value.kind_of? String
      value.gsub(',','.').to_f
    end

    def self.boolean_to_string(value)
      value ? 'S' : 'N'
    end
  end
end
