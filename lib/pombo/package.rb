module Pombo
  class Package
    attr_accessor :destination_zip_code, :origin_zip_code, :declared_value
    attr_reader :items, :length, :height, :width, :services

    def initialize(**args)
      { items: [], length: 0, height: 0, width: 0 }.each { |key, value| instance_variable_set("@#{ key }", value) }
      args = { declared_value: 0 }.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }
    end

    %i[in_hand delivery_notice].each do |method|
      define_method("#{ method }?"){ instance_variable_get "@#{ method }" }
    end

    %i[in_hand delivery_notice].each do |method|
      define_method("#{ method }=") do |value|
        if Pombo::Support::TRUE_VALUES.include? value
          instance_variable_set "@#{ method }", true
        elsif Pombo::Support::FALSE_VALUES.include? value
          instance_variable_set "@#{ method }", false
        else
          raise TypeError, "no implicit conversion of #{ value } into True or False"
        end
      end
    end

    def services=(services)
      @services = services.kind_of?(Array) ? services : [services]
    end

    def add_item(item = nil, **args)
      item = if item.kind_of?(Pombo::Package::Item)
                  item
                else
                  Pombo::Package::Item.new(args)
                end

      @items << item
      update_measures
      item
    end

    def weight
      @items.inject(0) { |sum, item| sum += item.weight }
    end

    def diameter
      return @items.first.diameter if single_item? && format == Pombo::Package::Format.find(:roll).code
      0
    end

    def format
      return @items.first.format if single_item?
      Pombo::Package::Format.find(:box).code
    end

    def volume
      @items.inject(0) { |sum, item| sum += item.volume }
    end

    def single_item?
      @items.size == 1 && @items.first.quantity == 1
    end

    private

    def update_measures
      @length = @height = @width = Math.cbrt volume
    end
  end
end
