module Pombo
  class Package::Item
    attr_accessor :weight, :length, :height, :width, :diameter, :quantity
    attr_reader :format

    def initialize(**args)
      args = { weight: 0.0, length: 0.0, height: 0.0, width: 0.0, diameter: 0.0, quantity: 1, format: Pombo::Package::Format::Box::CODE }.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }
    end

    def format=(value)
      formats = [Pombo::Package::Format::Box::CODE, Pombo::Package::Format::Roll::CODE, Pombo::Package::Format::Envelope::CODE]
      raise TypeError, "no implicit conversion of #{ value } into item format" unless formats.include?(value)
      @format = value
    end

    def volume
      case format
      when Pombo::Package::Format::Box::CODE
        package_volume * quantity
      when Pombo::Package::Format::Roll::CODE
        roll_volume * quantity
      when Pombo::Package::Format::Envelope::CODE
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