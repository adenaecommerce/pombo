require 'spec_helper'

describe Pombo::Package::Format do

  it 'contains a constant for the packet format' do
    expect(Pombo::Package::Format::PACKAGE).to equal 1
  end

  it 'contains a constant for the roll format' do
    expect(Pombo::Package::Format::ROLL).to equal 2
  end

  it 'contains a constant for the envelope format' do
    expect(Pombo::Package::Format::ENVELOPE).to equal 3
  end
end
