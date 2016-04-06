require 'spec_helper'

describe Pombo::Webservice::Base do
  before { stub_request(:any, "http://www.anything.com/") }

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
  end
end
