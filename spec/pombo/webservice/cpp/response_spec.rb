require 'spec_helper'

describe Pombo::Webservice::CPP::Response do
  let(:http_response) do
    OpenStruct.new ({
      body: %Q{
              <cResultado xmlns="http://tempuri.org/">
                <Servicos>
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
                  <cServico>
                    <Codigo>B9999</Codigo>
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
                    <obsFim>Test B</obsFim>
                  </cServico>
                </Servicos>
              </cResultado>
            }
    })
  end

  describe "#body" do
    subject { Pombo::Webservice::CPP::Response.new http_response }

    it 'returns an Array' do
			expect(subject.body).to be_an(Array)
    end

    it 'returns CPP services on Array' do
			expect(subject.body.first).to be_a(Pombo::Webservice::CPP::Service)
    end
  end
end
