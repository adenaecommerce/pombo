> ***
> Attention! if you are looking for documentation in English, [click here!](readmes/README-EN.md)
> ***

# Pombo
[![Build Status](https://travis-ci.org/adenaecommerce/pombo.svg?branch=master)](https://travis-ci.org/adenaecommerce/pombo)
[![Dependency Status](https://gemnasium.com/adenaecommerce/pombo.svg)](https://gemnasium.com/adenaecommerce/pombo)
[![Inline docs](http://inch-ci.org/github/adenaecommerce/pombo.svg?branch=master)](http://inch-ci.org/github/adenaecommerce/pombo)
[![Hex.pm](https://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/adenaecommerce/pombo/master)
[![Gem Version](https://badge.fury.io/rb/pombo.svg)](https://badge.fury.io/rb/pombo)
[![Code Climate](https://codeclimate.com/github/adenaecommerce/pombo/badges/gpa.svg)](https://codeclimate.com/github/adenaecommerce/pombo)

Pombo é uma gem que permite a utilização do webervice dos [Correios](http://correios.com.br/para-voce) para consulta de informacões
de envio de encomendas

## Funcionalidades

* Permite montar um pacote com vários itens
* Permite consultar o valor do transporte de um pacote
* Permite consultar o prazo de envio de um pacote
* Permite consultar o valor e o prazo de envio de um pacote
* Suporta Internacionalização
* Aceita um logger compatível com a interface do [Log4r](http://log4r.rubyforge.org/index.html)

## Instalação

    $ gem install pombo

ou adiciona essa linha no seu Gemfile

```ruby
gem 'pombo', '~> 1.0.0.beta'
```

e

    $ bundle install


## Configuração

> Os dados retornados ao realizar uma consulta são os mesmos fornecidos em uma agência dos Correios. As empresas
> podem contratar um serviço diferenciado e usar o código do seu contrato ao utilizar o Pombo.

Para alterar as configurações padrão, utilize o `#setup`

```ruby
Pombo.setup do |config|
  config.contract_code = 'AA99BB'
  config.password = '999999'
  config.extends_delivery = 0
  config.min_package = true
  config.request_timeout = 5
  config.log_level = Pombo::Logger::INFO
  config.logger = Pombo::Logger.new(STDOUT)
  config.locale = 'pt-BR'
end
```

> Os pacotes enviados pelos Correios possuem limitações de tamanho, usando a opção `min_package` você pode informar se caso o pacote não
> atinga as dimensões mínimas, que seja realizada a cotação com os tamanhos mínimos permitidos.

Se você precisar modificar qualquer configuração em um determinado momento, use o `#set`

```ruby
Pombo.set request_timeout: 10, locale: 'en'
```

> O `#set` não modifica as configurações default

## Formatos

Os formatos são objetos pré-definidos com informações fornecidas pelos Correios
Os Correios trabalha com os seguintes formatos: caixa, envelope e rolo. Todo item deve possuir um formato.

O formato do pacote é informado conforme os itens adicionado. Para mais de dois itens prevalece o formato caixa.

Listar todos os formatos suportados pelos serviços de entrega

```ruby
Pombo::Package::Format.all

# => [
# =>    #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
# =>    ....
# => ]
```

Encontrar um formato específico pelo código ou pelo nome

```ruby
Pombo::Package::Format.find '3'
# => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>

# ou

Pombo::Package::Format.find 'envelope'
# => #<OpenStruct code=3, name="Envelope", max_length=60, min_length=16, max_width=60, min_width=11, max_weight=1>
```

## Serviços

Os serviços são objetos pré-definidos com informações fornecidas pelos Correios. Para saber mais [clique aqui](http://www.correios.com.br/para-voce/envio/encomendas/encomendas)

Listar todos os serviços de entrega suportados pelos Correios.

```ruby
Pombo::Services.all

# => [
# =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (sem contrato)">,
# =>    ....
# => ]
```

Listar todos os serviços de um grupo.

```ruby
Pombo::Services.all :pac
# => [
# =>    #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (sem contrato)">,
# =>    ....
# => ]
```

Encontrar um serviço pelo seu código.

```ruby
Pombo::Services.find "41106"
# => #<OpenStruct code="41106", max_weight=30, name="PAC", description="PAC (sem contrato)">
```

## Pacotes

Os pacotes são os objetos enviados ao webservice para que seja realizada a consulta. Ele é composto por vários
items, o CEP de origem e o CEP de destino e alguns serviços opcionais, [veja aqui](https://www.correios.com.br/para-voce/envio/encomendas/servicos-opcionais)

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
> `Pombo::Package.new services: ["40010", "41068", "40568"]`

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

Para realizar uma consulta para saber o valor da entrega

```ruby
Pombo.shipping_value package
# =>  [
# =>    [0] #<Pombo::Webservice::CPP::Service:0x007fae1d1cb740 @code="40010", @value=31.3, @value_in_hand=0.0, @value_delivery_notice=0.0, @value_declared_value=0.0, @value_without_additions=31.3>
# =>  ]
```

## Log

Pombo aceita qualquer sistema de logger compatível com a interface do [Log4r](http://log4r.rubyforge.org/index.html).

Temos nosso próprio objeto de logger, `Pombo::Logger`, que por padrão envia as mensagens para a `STDOUT` do sistema e o nível é INFO.

```ruby
Pombo.logger.info('event.namespace'){ 'Any error message' }
# => 2016-05-13 15:15:49 -0300 | POMBO | event.namespace | INFO: Any error message
```

Para gravar em arquivo, você pode fazer algo parecido com isso:

```ruby
Pombo.setup do |config|
  config.log_level = Pombo::Logger::INFO
  config.logger = Pombo::Logger.new('caminho do arquivo')
end
```

## Como contribuir

Pombo é mantido pelo time de desenvolvimento da [Adena E-commerce Platform](http://www.adena.com.br/).

Relatórios de Bugs e pull requests são bem vindos no GitHub em https://github.com/adenaecommerce/pombo.
Você pode nos enviar a sua colaboração, mas deve aderir ao código de conduta [Contributor Covenant](http://contributor-covenant.org).

## Licença

MIT License. Veja o arquivo MIT-LICENSE.
