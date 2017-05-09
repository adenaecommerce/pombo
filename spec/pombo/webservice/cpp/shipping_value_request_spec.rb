require 'uri'
require 'spec_helper'

describe Pombo::Webservice::CPP::ShippingValueRequest do
  let(:package) do
    package = Pombo::Package.new(destination_zip_code: '29100000', origin_zip_code:  '29200000', services: '04014')
    package.add_item weight: 5, length: 5, height: 5, width: 5
    package
  end

  let(:request_hashes) { shipping_value_hash(package) }

  subject { Pombo::Webservice::CPP::ShippingValueRequest.new package }

  describe '#to_hash' do
    it 'returns a hash with the request parameters' do
      expect(subject.to_hash).to include(request_hashes)
    end
  end

  describe '#to_param' do
    it 'returning an HTTP query parameters' do
      expect(subject.to_param).to eq(URI.encode_www_form(request_hashes))
    end
  end
end
