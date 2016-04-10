> ***
> Attention! It is strongly advised not to use this version in production
> ***

# Pombo
[![Build Status](https://travis-ci.org/adenaecommerce/pombo.svg?branch=master)](https://travis-ci.org/adenaecommerce/pombo)
[![Dependency Status](https://gemnasium.com/adenaecommerce/pombo.svg)](https://gemnasium.com/adenaecommerce/pombo)
[![Inline docs](http://inch-ci.org/github/adenaecommerce/pombo.svg?branch=master)](http://inch-ci.org/github/adenaecommerce/pombo)
[![Hex.pm](https://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/adenaecommerce/pombo/master)
[![Gem Version](https://badge.fury.io/rb/pombo.svg)](https://badge.fury.io/rb/pombo)

Pombo is a gem that allows the use of webservices Brazilian shipping package service ([Correios](http://correios.com.br/para-voce))

## Features

* Lets put together a package with multiple items
* Lets see the shipping price of a package
* Lets see the period of sending a packet
* It allows you to check the time and shipping price of a package
* It supports internationalization

## Installation

    $ gem install pombo


## Configuration

> The data returned in sending queries are the same provided at a agency of Correios. Companies can hire a differentiated service and use the code of their contract in the use of Pombo.

To modify the default settings, use the #setup

```ruby
Pombo.setup do |config|
  config.contract_code = 'AA99BB'
  config.password = '999999'
  config.extends_delivery = 0
  config.request_timeout = 5
  config.log_level = :info
  config.logger = :logger
  config.locale = 'pt-BR'
end
```

If you need to modify some settings at a certain time, use the #set

```ruby
Pombo.set request_timeout: 10, locale: 'en'
```

## Formats

The formats are pre-defined objects with the information provided by the Correios

The Correios work with formats: box, envelope and roll. All item must have a format. The package takes a format as items added

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

The services are pre-defined objects with the information provided by the Correios

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

TODO: write

## Usage

TODO: write

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adenaecommerce/pombo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

MIT License. See the included MIT-LICENSE file.
