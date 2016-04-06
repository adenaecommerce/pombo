$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pombo'
require 'pry'
require 'webmock/rspec'

WebMock.disable_net_connect!

shared_examples 'configuration_data' do
  let(:default_options) do
    {
      contract_code: nil,
      password: nil,
      extends_delivery: 0,
      log_level: :info,
      logger: :logger,
      request_timeout: 5
    }
  end

  let(:options) do
    {
      contract_code: 'AA99BB',
      password: 'AA99CC',
      extends_delivery: 1,
      log_level: :warn,
      logger: :logger,
      request_timeout: 10
    }
  end
end
