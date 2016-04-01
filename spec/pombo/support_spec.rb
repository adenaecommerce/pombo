require 'spec_helper'

describe Pombo::Support do

  it 'contains the constant TRUE_VALUES with values as true' do
    expect(Pombo::Support::TRUE_VALUES).to eql([true, 1, '1', 't', 'T', 'true', 'TRUE'])
  end

  it 'contains the constant FALSE_VALUES with values as false' do
    expect(Pombo::Support::FALSE_VALUES).to eql([false, 0, '0', 'f', 'F', 'false', 'FALSE'])
  end

end
