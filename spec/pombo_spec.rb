require 'spec_helper'

describe Pombo do
  it 'has a version number' do
    expect(Pombo::VERSION).not_to be nil
  end

  describe 'API' do
    %i[configure shipping delivery_time shipping_value].each do |method|
      it "should respond to .#{ method }" do
        is_expected.to respond_to method
      end
    end
  end



end
