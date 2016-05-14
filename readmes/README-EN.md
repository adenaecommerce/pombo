# Pombo

Pombo is a gem that allows the use of the [Correios](http://correios.com.br/para-voce)
webservice to information query shipping packages.

## Features

* Lets put together a package with multiple items
* Lets see the shipping price of a package
* Lets see the period of sending a packet
* It allows you to check the time and shipping price of a package
* It supports internationalization
* Accepts a logger compatible with the interface [Log4r](http://log4r.rubyforge.org/index.html)

## Installation

    $ gem install pombo

or add a line in your Gemfile

```ruby
gem 'pombo', '~> 1.0.0.beta'
```

and

    $ bundle install


## Configuration

> The data returned in sending queries are the same provided at a agency of Correios.
> Companies can hire a differentiated service and use the code of their contract in the use of Pombo.

To modify the default settings, use the `#setup`

```ruby
Pombo.setup do |config|
  config.contract_code = 'AA99BB'
  config.password = '999999'
  config.extends_delivery = 0
  config.request_timeout = 5
  config.log_level = Pombo::Logger::INFO
  config.logger = Pombo::Logger.new(STDOUT)
  config.locale = 'pt-BR'
end
```

If you need to modify some settings at a certain time, use the `#set`

```ruby
Pombo.set request_timeout: 10, locale: 'en'
```

> The #set does not modify the default settings

## Formats

The formats are predefined objects to information provided by the Correios.
The Correios works with the following formats: box, envelope and roll. Every item must have a format.

The packet format is reported as items added. For more than two items prevails box format.


List all formats supported by delivery services

```ruby
Pombo::Package::Format.all

# => [
# =>    #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
# =>    ....
# => ]
```

Find a specific format by code or by name

```ruby
Pombo::Package::Format.find '3'
# => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>

# Or

Pombo::Package::Format.find 'envelope'
# => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
```

## Services
Services are predefined objects to information provided by the Post Office. To learn more, [click here](http://www.correios.com.br/para-voce/envio/encomendas/encomendas)

List all formats supported by delivery services

```ruby
Pombo::Services.all

# => [
# =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">,
# =>    ....
# => ]
```

Listing all the services of a group

```ruby
Pombo::Services.all :pac
# => [
# =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">,
# =>    ....
# => ]
```

Search for a service code

```ruby
Pombo::Services.find "41106"
# => #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">
```

## Packages

Packages are the objects sent to the webservice for the query to be performed.
It consists of several items, the zip code of origin and destination zip code and some optional services,
[see here](https://www.correios.com.br/para-voce/envio/encomendas/servicos-opcionais)

Creating a package:

```ruby
package = Pombo::Package.new ({
  destination_zip_code: '29160565',
  origin_zip_code: '29108046',
  services: "40010",
  in_hand: false,
  delivery_notice: false
})
# => <Pombo::Package:0x007fcfd32080f0 @items=[], @length=0, @height=0, @width=0, @declared_value=0, @destination_zip_code="29160565", @origin_zip_code="29108046">
```

> It can be informer an array of services to carry out the consultation on various services.
> `Pombo::Package.new services: ["40010", "41068", "40568"]`

Adding items:

```ruby
item = Pombo::Package::Item.new weight: 10, length: 17, height: 22, width: 22
package.add_item item
```

or you can be informed a hash

```ruby
package.add_item weight: 10, length: 15, height: 5, width: 10
```

Now we can get various information

```ruby
package.in_hand? # => false
package.delivery_notice? # => false
package.weight # => 10
package.diameter # => 0
package.format # => 1
package.volume # => 8228.0
package.single_item? # => true
```

## Usage

To perform a query to know the value and the delivery

```ruby
Pombo.shipping package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1cd9d1a0 @code="40010", @value=31.3, @delivery_time="1", @value_in_hand=0.0, @value_delivery_notice=0.0, @value_declared_value=0.0, @error_code="0", @value_without_additions=31.3, @delivery_home=true, @delivery_sartuday=true>
# =>  ]
```

To make an inquiry to find out the delivery time

```ruby
Pombo.delivery_time package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1da0b040 @code="40010", @delivery_time="1", @delivery_home=true, @delivery_sartuday=true>
# =>  ]
```

To perform a query to know the value of delivery

```ruby
Pombo.shipping_value package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1d1cb740 @code="40010", @value=31.3, @value_in_hand=0.0, @value_delivery_notice=0.0, @value_declared_value=0.0, @value_without_additions=31.3>
# =>  ]
```

## Log

Pombo accepts any logger system compatible with [Log4r](http://log4r.rubyforge.org/index.html) interface.
We have our own logger object, `Pombo::Logger`, which by default sends the messages to the system `STDOUT` and the level is INFO.

```ruby
Pombo.logger.info('event.namespace'){ 'Any error message' }
# => 2016-05-13 15:15:49 -0300 | POMBO | event.namespace | INFO: Any error message
```

To save file, you can do something like this:

```ruby
Pombo.setup do |config|
  config.log_level = Pombo::Logger::INFO
  config.logger = Pombo::Logger.new('caminho do arquivo')
end
```

## Contributing

Pombo is maintained by the development team of [Adena E-commerce Platform](http://www.adena.com.br/).

Bug reports and pull requests are welcome on GitHub at https://github.com/adenaecommerce/pombo.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

MIT License. See the included MIT-LICENSE file.
