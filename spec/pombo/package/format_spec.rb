require 'spec_helper'

describe Pombo::Package::Format do
  describe ".all" do
    it 'returns an array of formats' do
      expect(subject.all).to be_an(Array)
    end

    it 'returns all formats' do
      expect(subject.all.size).to eq(3)
    end
  end

  describe '.find' do
    it 'returns the format to the related code' do
      expect(subject.find('1').code).to eq('1')
    end

    context 'when a format is informed' do
      it 'returns the Box' do
        expect(subject.find(:box).code).to eq('1')
      end

      it 'returns the Package' do
        expect(subject.find(:package).code).to eq('1')
      end

      it 'returns the Roll' do
        expect(subject.find(:roll).code).to eq('2')
      end

      it 'returns the Prism' do
        expect(subject.find(:prism).code).to eq('2')
      end

      it 'returns the Envelope' do
        expect(subject.find(:envelope).code).to eq('3')
      end
    end
  end
end
