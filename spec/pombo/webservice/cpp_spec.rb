require 'spec_helper'

describe Pombo::Webservice::CPP do
  let(:configurations) { Pombo::Configuration.new }

  let(:package1) do
    package = Pombo::Package.new(destination_zip_code: '29100000', origin_zip_code:  '29200000', services: '40010')
    package.add_item weight: 5, length: 5, height: 5, width: 5
    package
  end

  let(:package2) do
    package = Pombo::Package.new(destination_zip_code: '29100000', origin_zip_code:  '29200000', services: ['40010', '40020'])
    package.add_item weight: 5, length: 5, height: 5, width: 5
    package.add_item weight: 10, length: 10, height: 10, width: 10
    package
  end

  let(:shipping_params1) { shipping_hash(package1) }
  let(:shipping_params2) { shipping_hash(package2) }
  let(:delivery_time_params1) { delivery_time_hash(package1) }
  let(:delivery_time_params2) { delivery_time_hash(package2) }
  let(:shipping_value_params1) { shipping_value_hash(package1) }
  let(:shipping_value_params2) { shipping_value_hash(package2) }

  subject { Pombo::Webservice::CPP }

  describe '#shipping' do
    context 'when performing the query a service' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: shipping_params1).to_return(body: File.read('spec/support/cpp_shipping_response1.xml'))
      end

      it 'access the service URL' do
        subject.shipping package1
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: shipping_params1)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.shipping(package1)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.shipping(package1).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'return only one service' do
        expect(subject.shipping(package1).size).to eq(1)
      end
    end

    context 'when performing the query multiple services' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: shipping_params2).to_return(body: File.read('spec/support/cpp_shipping_response2.xml'))
      end

      it 'access the service URL' do
        subject.shipping package2
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: shipping_params2)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.shipping(package2)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.shipping(package2).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'returns more than one service' do
        expect(subject.shipping(package2).size).to be > 1
      end
    end
  end

  describe '#delivery_time' do
    context 'when performing the query a service' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params1).to_return(body: File.read('spec/support/cpp_delivery_time_response1.xml'))
      end

      it 'access the service URL' do
        subject.delivery_time package1
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params1)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.delivery_time(package1)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.delivery_time(package1).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'return only one service' do
        expect(subject.delivery_time(package1).size).to eq(1)
      end
    end

    context 'when performing the query multiple services' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params2).to_return(body: File.read('spec/support/cpp_delivery_time_response2.xml'))
      end

      it 'access the service URL' do
        subject.delivery_time package2
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params2)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.delivery_time(package2)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.delivery_time(package2).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'returns more than one service' do
        expect(subject.delivery_time(package2).size).to be > 1
      end
    end
  end

  describe '#delivery_time' do
    context 'when performing the query a service' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params1).to_return(body: File.read('spec/support/cpp_delivery_time_response1.xml'))
      end

      it 'access the service URL' do
        subject.delivery_time package1
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params1)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.delivery_time(package1)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.delivery_time(package1).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'return only one service' do
        expect(subject.delivery_time(package1).size).to eq(1)
      end
    end

    context 'when performing the query multiple services' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params2).to_return(body: File.read('spec/support/cpp_delivery_time_response2.xml'))
      end

      it 'access the service URL' do
        subject.delivery_time package2
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrazo").with(query: delivery_time_params2)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.delivery_time(package2)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.delivery_time(package2).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'returns more than one service' do
        expect(subject.delivery_time(package2).size).to be > 1
      end
    end
  end

  describe '#shipping_value' do
    context 'when performing the query a service' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPreco").with(query: shipping_value_params1).to_return(body: File.read('spec/support/cpp_shipping_value_response1.xml'))
      end

      it 'access the service URL' do
        subject.shipping_value package1
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPreco").with(query: shipping_value_params1)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.shipping_value(package1)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.shipping_value(package1).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'return only one service' do
        expect(subject.shipping_value(package1).size).to eq(1)
      end
    end

    context 'when performing the query multiple services' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPreco").with(query: shipping_value_params2).to_return(body: File.read('spec/support/cpp_shipping_value_response2.xml'))
      end

      it 'access the service URL' do
        subject.shipping_value package2
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPreco").with(query: shipping_value_params2)).to have_been_made.once
      end

      it 'returns an Array' do
        expect(subject.shipping_value(package2)).to be_an(Array)
      end

      it 'returns CPP services on Array' do
        expect(subject.shipping_value(package2).first).to be_a(Pombo::Webservice::CPP::Service)
      end

      it 'returns more than one service' do
        expect(subject.shipping_value(package2).size).to be > 1
      end
    end
  end


end
