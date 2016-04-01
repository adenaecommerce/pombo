module Pombo
  class Package
    attr_accessor :destination_zip_code, :origin_zip_code
    attr_reader :items, :length, :height, :width

    def initialize
      { items: [], length: 0, height: 0, width: 0 }.each { |key, value| instance_variable_set("@#{ key }", value) }
    end

    %i[in_hand declared_value delivery_notice].each do |method|
      define_method("#{ method }?"){ instance_variable_get "@#{ method }" }
    end

    %i[in_hand declared_value delivery_notice].each do |method|
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
      return @items.first.diameter if @items.size == 1 && format == Pombo::Package::Format::ROLL
      0
    end

    def format
      return @items.first.format if @items.size == 1
      Pombo::Package::Format::PACKAGE
    end

    def volume
      @items.inject(0) { |sum, item| sum += item.volume }
    end

    private

    def update_measures
      @length = @height = @width = Math.cbrt volume
    end
  end
end
