require 'spec_helper'

describe Pombo::Webservice::CPP::Service do
  let(:xml_text) do
    %Q{
      <cServico>
        <Codigo>A9999</Codigo>
        <Valor>99,99</Valor>
        <PrazoEntrega>1</PrazoEntrega>
        <ValorMaoPropria>9,99</ValorMaoPropria>
        <ValorAvisoRecebimento>9,99</ValorAvisoRecebimento>
        <ValorValorDeclarado>9</ValorValorDeclarado>
        <EntregaDomiciliar>S</EntregaDomiciliar>
        <EntregaSabado>N</EntregaSabado>
        <Erro>0</Erro>
        <MsgErro/>
        <ValorSemAdicionais>99,99</ValorSemAdicionais>
        <obsFim>Test A</obsFim>
      </cServico>
    }
  end

  describe 'API' do
    %i[code value delivery_time value_in_hand value_declared_value value_without_additions
      value_delivery_notice delivery_home delivery_sartuday error_code error_message comments].each do |method|
      it { is_expected.to respond_to method }
    end
  end

  context 'when performing the convention values' do
    let(:service) { subject.class.parse(xml_text) }

    %i[value value_in_hand value_delivery_notice value_declared_value value_without_additions].each do |method|
      it "converts the #{ method } to float" do
        expect(service.send(method)).to be_a(Float)
      end
    end

    it 'converts the delivery_home to boolean' do
      expect(service.delivery_home).to be_a(TrueClass)
    end

    it 'converts the delivery_sartuday to boolean' do
      expect(service.delivery_sartuday).to be_a(FalseClass)
    end
  end
end
