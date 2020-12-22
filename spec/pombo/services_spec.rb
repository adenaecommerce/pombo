require 'spec_helper'

describe Pombo::Services do
  describe ".all" do
    it 'returns an array of services' do
      expect(subject.all).to be_an(Array)
    end

    it 'returns all services' do
      expect(subject.all.size).to eq(21)
    end

    context 'when a service is informed' do
      it 'returns all PAC' do
        expect(subject.all(:pac).size).to eq(5)
      end

      it 'returns all SEDEX' do
        expect(subject.all(:sedex).size).to eq(12)
      end

      it 'returns all E-SEDEX' do
        expect(subject.all(:e_sedex).size).to eq(6)
      end
    end
  end

  describe '.find' do
     it 'returns the service to the related code' do
      expect(subject.find('40568').code).to eq('40568')
     end
  end
end
