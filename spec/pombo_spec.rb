require 'spec_helper'

describe Pombo do
  let(:package) { spy("package") }

  include_examples 'configuration_data'

  it 'has a version number' do
    expect(Pombo::VERSION).not_to be nil
  end

  describe 'API' do
    %i[setup set configurations shipping delivery_time shipping_value].each do |method|
      it "should respond to .#{ method }" do
        is_expected.to respond_to method
      end
    end
  end

  describe '.setup' do
    it 'change the default settings by a block' do
      expect do
        subject.setup do |config|
          config.contract_code    = options[:contract_code]
          config.password         = options[:password]
          config.extends_delivery = options[:extends_delivery]
          config.log_level        = options[:log_level]
          config.logger           = options[:logger]
          config.request_timeout  = options[:request_timeout]
        end
      end.to change{ Pombo::Configuration.default }.to options
    end

    it 'throw exception if not past a block' do
      expect{ subject.setup }.to  raise_error Pombo::ConfigurationError
    end
  end

  describe '.set' do
    it 'returns the configuration object' do
      expect(subject.set(contract_code: 'something', password: 'something')).to be_a Pombo::Configuration
    end

    it 'change the current object settings' do
      expect{ subject.set(contract_code: 'something', password: 'something') }.to change{ subject.configurations }
    end

    it 'does not change the default settings' do
      expect{ subject.set(contract_code: 'something', password: 'something') }.not_to change{ Pombo::Configuration.default }
    end
  end

  describe '.shipping' do
    it 'uses the webservice CPP to calculate' do
      expect(Pombo::Webservice::CPP).to receive(:shipping).with(package)

      Pombo.shipping package
    end
  end

  describe '.delivery_time' do
    it 'uses the webservice CPP to calculate' do
      expect(Pombo::Webservice::CPP).to receive(:delivery_time).with(package)

      Pombo.delivery_time package
    end
  end

  describe '.shipping_value' do
    it 'uses the webservice CPP to calculate' do
      expect(Pombo::Webservice::CPP).to receive(:shipping_value).with(package)

      Pombo.shipping_value package
    end
  end

  describe '.t' do
    it 'use the given locale in settings' do
      I18n.locale = :en
      expect(subject.t('webservices.cpp.error.0')).to eq('Processamento com sucesso')
    end
  end
end
