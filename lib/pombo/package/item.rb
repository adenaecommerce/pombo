module Pombo
  # Item is the object that will be sent in the package through the Brazilian Post Service
  #
  # By default the quantity is 1 and the format is +Pombo::Package::Format.find(:box).code+
  class Package::Item
    attr_accessor :weight, :length, :height, :width, :diameter, :quantity, :format

    def initialize(**args)
      args = { weight: 0.0, length: 0.0, height: 0.0, width: 0.0, diameter: 0.0, quantity: 1, format: Pombo::Package::Format.find(:box).code }.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }
    end

    # Calculates the volume item in accordance with the format
    # @return [Float] the volume value
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
