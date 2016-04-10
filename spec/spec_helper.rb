$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'webmock/rspec'
require 'pombo'

WebMock.disable_net_connect!

shared_examples 'configuration_data' do
  let(:default_options) do
    {
      contract_code: nil,
      password: nil,
      extends_delivery: 0,
      log_level: :info,
      logger: :logger,
      request_timeout: 5,
      locale: 'pt-BR'
    }
  end

  let(:options) do
    {
      contract_code: 'AA99BB',
      password: 'AA99CC',
      extends_delivery: 1,
      log_level: :warn,
      logger: :logger,
      request_timeout: 10,
      locale: 'pt-BR'
    }
  end
end

def shipping_hash(package)
  {
    nCdEmpresa: Pombo.configurations.contract_code.to_s,
    sDsSenha: Pombo.configurations.password.to_s,
    nCdServico: package.services.join(','),
    sCepOrigem: package.origin_zip_code,
    sCepDestino: package.destination_zip_code,
    nVlPeso: package.weight,
    nCdFormato: package.format,
    nVlComprimento: package.length,
    nVlAltura: package.height,
    nVlLargura: package.width,
    nVlDiametro: package.diameter,
    sCdMaoPropria: Pombo::Support.boolean_to_string(package.in_hand?),
    nVlValorDeclarado: package.declared_value,
    sCdAvisoRecebimento: Pombo::Support.boolean_to_string(package.delivery_notice?)
  }
end

def delivery_time_hash(package)
  {
    nCdServico: package.services.join(','),
    sCepOrigem: package.origin_zip_code,
    sCepDestino: package.destination_zip_code,
  }
end

def shipping_value_hash(package)
  {
    nCdEmpresa: Pombo.configurations.contract_code.to_s,
    sDsSenha: Pombo.configurations.password.to_s,
    nCdServico: package.services.join(','),
    sCepOrigem: package.origin_zip_code,
    sCepDestino: package.destination_zip_code,
    nVlPeso: package.weight,
    nCdFormato: package.format,
    nVlComprimento: package.length,
    nVlAltura: package.height,
    nVlLargura: package.width,
    nVlDiametro: package.diameter,
    sCdMaoPropria: Pombo::Support.boolean_to_string(package.in_hand?),
    nVlValorDeclarado: package.declared_value,
    sCdAvisoRecebimento: Pombo::Support.boolean_to_string(package.delivery_notice?)
  }
end
