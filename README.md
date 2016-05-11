> ***
> Attention! if you are looking for documentation in English, [click here!](readmes/README-EN.md)
> ***

# Pombo
[![Build Status](https://travis-ci.org/adenaecommerce/pombo.svg?branch=master)](https://travis-ci.org/adenaecommerce/pombo)
[![Dependency Status](https://gemnasium.com/adenaecommerce/pombo.svg)](https://gemnasium.com/adenaecommerce/pombo)
[![Inline docs](http://inch-ci.org/github/adenaecommerce/pombo.svg?branch=master)](http://inch-ci.org/github/adenaecommerce/pombo)
[![Hex.pm](https://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/adenaecommerce/pombo/master)
[![Gem Version](https://badge.fury.io/rb/pombo.svg)](https://badge.fury.io/rb/pombo)

Pombo é uma gem que permite a utilização do webervice dos [Correios](http://correios.com.br/para-voce) para consulta de frete

## Funcionalidades

* Permite montar um pacote com vários itens
* Permite consultar o valor do transporte de um pacote
* Permite consultar o prazo de envio de um pacote
* Permite consultar o valor e o prazo de envio de um pacote
* Suporta Internacionalização

## Instalação

    $ gem install pombo


## Configuração

> Os dados retornados ao realizar uma consultas são os mesmos fornecidos em uma agência de Correios. As empresas podem contratar um
> serviço diferenciado e usar o código do seu contrato ao utilizar o Pombo

Para alterar as configurações default, use o `#setup`

```ruby
Pombo.setup do |config|
  config.contract_code = 'AA99BB'
  config.password = '999999'
  config.extends_delivery = 0
  config.request_timeout = 5
  config.log_level = :info
  config.logger = Logger.new
  config.locale = 'pt-BR'
end
```

Se você precisar modificar qualquer configuração em um determinado momento, use o `#set`

```ruby
Pombo.set request_timeout: 10, locale: 'en'
```

> O `#set` não modifica as configurações default

## Formatos

Os serviços são objetos pré-definidos com informações fornecidas pelo Correios

Os Correios trabalha com os sequintes formatos: caixa, envelope e rolo. Todo item deve possuir um formato. O formato do pacote é informado
conforme os itens adicionado. Para mais de dois itens prevalece o formato caixa

Lista todos os formatos suportados pelos serviços de entrega

```ruby
Pombo::Package::Format.all

# => [
# =>    #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
# =>    ....
# => ]
```

Encontra um formato específico pelo código ou pelo nome

```ruby
Pombo::Package::Format.find '3'
# => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>

# Or

Pombo::Package::Format.find 'envelope'
# => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
```

## Serviços

Os serviços são objetos pré-definidos com informações fornecidas pelo Correios

Lista todos os serviços suportados pelos serviços de entrega

```ruby
Pombo::Services.all

# => [
# =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">,
# =>    ....
# => ]
```

Lista todos os serviços de um grupo

```ruby
Pombo::Services.all :pac
# => [
# =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">,
# =>    ....
# => ]
```

Encontra um serviço pelo seu código

```ruby
Pombo::Services.find "41106"
# => #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (without contract)">
```

## Pacotes

Os pacotes são os objetos enviados ao webservice para ser realizada a consulta. Ele é composto por vários items, o CEP de origem e o CEP de destino.

Criando um pacote:

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

> Pode ser informador um array de serviços para realizar a consulta em vários serviços.

Adicionando items:

```ruby
item = Pombo::Package::Item.new weight: 10, length: 17, height: 22, width: 22
package.add_item item
```

ou pode ser informado um hash

```ruby
package.add_item weight: 10, length: 15, height: 5, width: 10
```

Agora podemos obter várias informações

```ruby
package.in_hand? # => false
package.delivery_notice? # => false
package.weight # => 10
package.diameter # => 0
package.format # => 1
package.volume # => 8228.0
package.single_item? # => true
```

## Utilizando o Pombo

Para realizar uma consulta para saber o valor e o prazo de entrega

```ruby
Pombo.shipping package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1cd9d1a0 @code="40010", @value=31.3, @delivery_time="1", @value_in_hand=0.0, @value_delivery_notice=0.0, @value_declared_value=0.0, @error_code="0", @value_without_additions=31.3, @delivery_home=true, @delivery_sartuday=true>
# =>  ]
```

Para realizar uma consulta para saber o prazo de entrega

```ruby
Pombo.delivery_time package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1da0b040 @code="40010", @delivery_time="1", @delivery_home=true, @delivery_sartuday=true>
# =>  ]
```

para realizar uma consulta para saber o valor da entrega

```ruby
Pombo.shipping_value package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1d1cb740 @code="40010", @value=31.3, @value_in_hand=0.0, @value_delivery_notice=0.0, @value_declared_value=0.0, @value_without_additions=31.3>
# =>  ]
```

## Log

TODO: write


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adenaecommerce/pombo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

MIT License. See the included MIT-LICENSE file.
