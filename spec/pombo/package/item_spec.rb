require 'spec_helper'

describe Pombo::Package::Item do
  shared_examples 'default_value' do |method, value|
    it "starts with the default value" do
      expect(subject.send(method)).to equal(value)
    end
  end

  shared_examples 'calculate_volume' do |format_title, format, quantity, result|
    it "calculates the volume to the #{ format_title } format" do
      subject.format = format
      expect(subject.volume).to equal(result)
    end

    it "calculates the volume to the #{ format_title } format with the amount iqual #{ quantity }" do
      subject.format = format
      subject.quantity = quantity
      expect(subject.volume).to equal(result * quantity)
    end
  end

  describe '#quantity' do
    include_examples 'default_value', :quantity, 1
  end

  describe '#weight' do
    include_examples 'default_value', :weight, 0.0
  end

  describe '#length' do
    include_examples 'default_value', :length, 0.0
  end

  describe '#height' do
    include_examples 'default_value', :height, 0.0
  end

  describe '#width' do
    include_examples 'default_value', :width, 0.0
  end

  describe '#diameter' do
    include_examples 'default_value', :diameter, 0.0
  end

  describe '#format' do
    include_examples 'default_value', :format, Pombo::Package::Format::PACKAGE

    it 'throw exception if the format is not supported' do
      expect{ subject.format = 3434324234 }.to raise_error(TypeError)
    end
  end

  describe '#volume' do
    subject { Pombo::Package::Item.new weight: 10, length: 15, height: 5, width: 10, diameter: 8 }

    include_examples 'calculate_volume', 'package', Pombo::Package::Format::PACKAGE, 2, 750.0

    include_examples 'calculate_volume', 'roll', Pombo::Package::Format::ROLL, 2, 251.33

    include_examples 'calculate_volume', 'envelope', Pombo::Package::Format::ENVELOPE, 2, 0
  end
end
