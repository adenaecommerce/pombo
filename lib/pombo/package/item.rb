module Pombo
  class Package::Item
    attr_accessor :weight, :length, :height, :width, :diameter, :quantity
    attr_reader :format

    def initialize(**args)
      args = { weight: 0.0, length: 0.0, height: 0.0, width: 0.0, diameter: 0.0, quantity: 1, format: Pombo::Package::Format.find(:box).code }.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }
    end

    def format=(value)
      formats = Pombo::Package::Format.all.map(&:code)
      raise TypeError, "no implicit conversion of #{ value } into item format" unless formats.include?(value)
      @format = value
    end

    def volume
      case format
      when Pombo::Package::Format.find(:box).code
        package_volume * quantity
      when Pombo::Package::Format.find(:roll).code
        roll_volume * quantity
      when Pombo::Package::Format.find(:envelope).code
        0
      end
    end

    private

    def package_volume
      length.to_f * width.to_f * height.to_f
    end

    def roll_volume
      radius = diameter.to_f / 2
      (height.to_f * (Math::PI * radius**2)).round(2)
    end
  end
end
