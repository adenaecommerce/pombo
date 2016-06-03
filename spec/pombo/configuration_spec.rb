require 'spec_helper'

describe Pombo::Configuration do
  let(:logger){ spy('stdout') }
  before { allow(Pombo).to receive(:logger).and_return(logger) }

  include_examples 'configuration_data'

  describe '.default' do
    before { allow(Pombo::Logger).to receive(:new).and_return(spy('stdout')) }
    subject { Pombo::Configuration.new(default_options).set_default }

    it 'returns a Hash object' do
      expect(subject.class.default).to be_a Hash
    end

    it 'returns the default settings' do
      expect(subject.class.default).to eq(default_options)
    end
  end

  describe '#min_package?' do
    subject { Pombo::Configuration.new options }

    it 'returns true when min_package is true' do
      subject.min_package = true
      expect(subject.min_package?).to be true
    end

    it 'returns false when min_package is false' do
      subject.min_package = false
      expect(subject.min_package?).to be false
    end
  end

  describe '#set_default' do
    subject { Pombo::Configuration.new options }

    it 'send message to log' do
      expect(logger).to receive(:info).with('update.configuration') { 'Update the default settings' }
      subject.set_default
    end

    it 'performs a snapshot of the object and saved as default' do
      subject.set_default
      expect(subject.class.default).to eq(options)
    end

    it 'returns a Pombo::Configuration object' do
      expect(subject.set_default).to be_a Pombo::Configuration
    end
  end

  describe '.setup' do
    before { Pombo::Configuration.new(default_options).set_default }

    context 'when the options are correct' do
      it 'stores settings' do
        expect do
          subject.class.setup do |config|
            config.contract_code    = options[:contract_code]
            config.password         = options[:password]
            config.extends_delivery = options[:extends_delivery]
            config.min_package      = options[:min_package]
            config.log_level        = options[:log_level]
            config.logger           = options[:logger]
            config.request_timeout  = options[:request_timeout]
            config.locale           = options[:locale]
          end
        end.to change(subject.class, :default).to options
      end

      it 'returns a Pombo::Configuration object' do
        settings = Proc.new { |config| config.contract_code = options[:contract_code] }
        expect(subject.class.setup{ settings }).to eq Pombo::Configuration
      end
    end

    context 'when the configuration is invalid' do
      it 'throw exception if not past a block' do
        expect{ subject.class.setup }.to  raise_error Pombo::ConfigurationError
      end
    end
  end
end
