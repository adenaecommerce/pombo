module Pombo
  # This is the composite package of items that will be sent
  #
  # @example
  #   package = Pombo::Package.new ({
  #     destination_zip_code: '29999000',
  #     origin_zip_code: '28888000',
  #     services: "40010",
  #     in_hand: false,
  #     delivery_notice: false
  #   })
  #   # => <Pombo::Package:0x007fcfd32080f0 @items=[], @length=0, @height=0, @width=0, @declared_value=0, @destination_zip_code="29999000", @origin_zip_code="28888000">
  #
  #   package.add_item weight: 5, length: 4, height: 3, width: 5, diameter: 0
  #   package.add_item weight: 4, length: 10, height: 5, width: 5, diameter: 5, format: Pombo::Package::Format.find(:roll).code
  #   package.in_hand? # => false
  #   package.delivery_notice? # => false
  #   package.weight # => 9
  #   package.diameter # => 0
  #   package.format # => 1
  #   package.volume # => 158.17000000000002
  #   package.single_item? # => false
  class Package
    attr_accessor :destination_zip_code, :origin_zip_code, :declared_value
    attr_reader :items, :length, :height, :width, :services

    def initialize(**args)
      { items: [], length: 0, height: 0, width: 0 }.each { |key, value| instance_variable_set("@#{ key }", value) }
      args = { declared_value: 0 }.merge(args)
      args.each { |key, value| __send__("#{ key }=", value) }
    end

    # @!method in_hand?
    #   Informs you are contracted delivery in hand service
    # @!method delivery_notice?
    #   Informs you are contracted delivery notice service
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

    # The services used to send the package
    def services=(services)
      @services = services.kind_of?(Array) ? services : [services]
    end

    # It allows you to add an item to the package
    # @return [Pombo::Package::Item] the added item
    #
    # @example
    #   item = Pombo::Package::Item.new weight: 5, length: 4, height: 3, width: 5, diameter: 0
    #   package.add_item item
    #
    #   # => Or
    #
    #   package.add_item weight: 5, length: 4, height: 3, width: 5, diameter: 0
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

    # @return [Float] the total weight of the items
    def weight
      @items.inject(0) { |sum, item| sum += item.weight }
    end

    # @return [Float] the total diameter of the items
    def diameter
      return @items.first.diameter if single_item? && format == Pombo::Package::Format.find(:roll).code
      0
    end

    # @return [Fixnum] the code of the packet format
    #   For packages with more than one item format will be 1 (:box)
    def format
      return @items.first.format if single_item?
      Pombo::Package::Format.find(:box).code
    end

    # @return [Float] the total volume of the items
    def volume
      @items.inject(0) { |sum, item| sum += item.volume }
    end

    # @return [Boolean] tells if the package contains only one item
    def single_item?
      @items.size == 1 && @items.first.quantity == 1
    end

    private

    def update_measures
      # TODO use the values of the package when there is only one
      @length = @height = @width = Math.cbrt volume
    end
  end
end
