require 'spec_helper'

describe Pombo::Support do

  it 'contains the constant TRUE_VALUES with values as true' do
    expect(Pombo::Support::TRUE_VALUES).to eql([true, 1, '1', 't', 'T', 'true', 'TRUE'])
  end

  it 'contains the constant FALSE_VALUES with values as false' do
    expect(Pombo::Support::FALSE_VALUES).to eql([false, 0, '0', 'f', 'F', 'false', 'FALSE'])
  end

  describe '.str_real_to_float' do
    it 'convert real string to float' do
      expect(subject.str_real_to_float('2,99')).to eq(2.99)
    end

    it 'throw exception if the value is not string' do
      expect { subject.str_real_to_float(2) }.to raise_error TypeError
    end
  end

end
