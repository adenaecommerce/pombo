require 'spec_helper'

describe Pombo::Webservice::CPP::Response do
  let(:http_response) do
    OpenStruct.new body: File.read('spec/support/cpp_shipping_response1.xml')
  end

  describe "#body" do
    subject { Pombo::Webservice::CPP::Response.new http_response }

    it 'returns an Array' do
			expect(subject.body).to be_an(Array)
    end

    it 'returns CPP services on Array' do
			expect(subject.body.first).to be_a(Pombo::Webservice::CPP::ServiceResponse)
    end
  end
end
