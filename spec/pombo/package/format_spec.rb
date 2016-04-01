require 'spec_helper'

shared_examples 'constant_value' do |name, value|
  it "contains the constant #{ name } equal to #{ value }" do
    expect(described_class.const_get(name)).to equal value
  end
end

describe Pombo::Package::Format::Box do
  include_examples 'constant_value', :CODE, 1
  include_examples 'constant_value', :MAX_LENGTH, 105
  include_examples 'constant_value', :MIN_LENGTH, 16
  include_examples 'constant_value', :MAX_HEIGHT, 105
  include_examples 'constant_value', :MIN_HEIGHT, 2
  include_examples 'constant_value', :MAX_WIDTH, 105
  include_examples 'constant_value', :MIN_WIDTH, 11
  include_examples 'constant_value', :MAX_DIMENSION, 200
end

describe Pombo::Package::Format::Roll do
  include_examples 'constant_value', :CODE, 2
  include_examples 'constant_value', :MAX_LENGTH, 105
  include_examples 'constant_value', :MIN_LENGTH, 18
  include_examples 'constant_value', :MAX_DIAMETER, 91
  include_examples 'constant_value', :MIN_DIAMETER, 5
  include_examples 'constant_value', :MAX_DIMENSION, 200
end

describe Pombo::Package::Format::Envelope do
  include_examples 'constant_value', :CODE, 3
  include_examples 'constant_value', :MAX_LENGTH, 60
  include_examples 'constant_value', :MIN_LENGTH, 16
  include_examples 'constant_value', :MAX_WIDTH, 60
  include_examples 'constant_value', :MIN_WIDTH, 11
end
