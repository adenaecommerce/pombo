require 'spec_helper'

describe Pombo::Webservice::Base do
  let(:logger){ spy('stdout') }

  before do
    stub_request(:any, "http://www.anything.com/").to_return(body: "abc")
    allow(Pombo).to receive(:logger).and_return(logger)
  end

  subject { Pombo::Webservice::Base }

  describe '#get' do
    it 'access the specified URL' do
      subject.get "http://www.anything.com"
      expect(a_request(:get, "http://www.anything.com/")).to have_been_made.once
    end

    it 'throw exception for bad URL' do
      expect { subject.get "www.anything.com" }.to raise_error Pombo::WebserviceError
    end

    it 'throw exception for bad parameters' do
      expect { subject.get "http://www.anything.com", 1 }.to raise_error Pombo::WebserviceError
    end

    it 'send message to log' do
      expect(logger).to receive(:info).with('start_request.webservice') { "GET request: http://www.anything.com/" }
      expect(logger).to receive(:info).with('end_request.webservice') { "GET 200 response: abc" }
      subject.get "http://www.anything.com/"
    end
  end
end
