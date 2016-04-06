require 'spec_helper'

describe Pombo::Webservice::CPP do
  let(:configurations) { Pombo::Configuration.new }

  let(:package1) do
    package = Pombo::Package.new(destination_zip_code: '29100000', origin_zip_code:  '29200000', services: '40010')
    package.add_item weight: 5, length: 5, height: 5, width: 5
    package
  end

  let(:params1) do
    {
      "nCdEmpresa" => configurations.contract_code,
      "sDsSenha" => configurations.password,
      "nCdServico" => package1.services.join(','),
      "sCepOrigem" => package1.origin_zip_code,
      "sCepDestino" => package1.destination_zip_code,
      "nVlPeso" => package1.weight,
      "nCdFormato" => package1.format,
      "nVlComprimento" => package1.length,
      "nVlAltura" => package1.height,
      "nVlLargura" => package1.width,
      "nVlDiametro" => package1.diameter,
      "sCdMaoPropria" => Pombo::Support.boolean_to_string(package1.in_hand?),
      "nVlValorDeclarado" => package1.declared_value,
      "sCdAvisoRecebimento" => Pombo::Support.boolean_to_string(package1.delivery_notice?)
    }
  end

  let(:package2) do
    package = Pombo::Package.new(destination_zip_code: '29100000', origin_zip_code:  '29200000', services: ['40010', '40020'])
    package.add_item weight: 5, length: 5, height: 5, width: 5
    package.add_item weight: 10, length: 10, height: 10, width: 10
    package
  end

  let(:params2) do
    {
      nCdEmpresa: configurations.contract_code,
      sDsSenha: configurations.password,
      nCdServico: package2.services.join(','),
      sCepOrigem: package2.origin_zip_code,
      sCepDestino: package2.destination_zip_code,
      nVlPeso: package2.weight,
      nCdFormato: package2.format,
      nVlComprimento: package2.length,
      nVlAltura: package2.height,
      nVlLargura: package2.width,
      nVlDiametro: package2.diameter,
      sCdMaoPropria: Pombo::Support.boolean_to_string(package2.in_hand?),
      nVlValorDeclarado: package2.declared_value,
      sCdAvisoRecebimento: Pombo::Support.boolean_to_string(package2.delivery_notice?)
    }
  end

  subject { Pombo::Webservice::CPP }

  describe '#shipping' do
    context 'when performing the query a service' do
      before do
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: params1).to_return(body: File.read('spec/support/cpp_shipping_response1.xml'))
      end

      it 'access the service URL' do
        subject.shipping package1
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: params1)).to have_been_made.once
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
        stub_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: params2).to_return(body: File.read('spec/support/cpp_shipping_response2.xml'))
      end

      it 'access the service URL' do
        subject.shipping package2
        expect(a_request(:get, "#{ Pombo::Webservice::CPP::URL }/CalcPrecoPrazo").with(query: params2)).to have_been_made.once
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
end
