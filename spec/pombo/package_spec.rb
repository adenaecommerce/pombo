require 'spec_helper'

describe Pombo::Package do
  shared_examples 'updates_measures' do |property|
    it "updates #{ property }" do
      subject.add_item length: 1, height: 1, width: 1
      expect{ subject.add_item(length: 1, height: 1, width: 1) }.to change(subject, property.to_sym)
    end
  end

  %i[in_hand declared_value delivery_notice].each do |method|
    describe "##{ method }?" do
      it { is_expected.to respond_to "#{ method }?" }
    end
  end

  %i[in_hand declared_value delivery_notice].each do |method|
    describe "##{ method }=" do
      it 'throw exception not boolean values' do
        expect { subject.send("#{ method }=", 'anything') }.to raise_error TypeError
      end
    end
  end

  describe '#volume' do
    it 'returns the sum of all items of the volume' do
      item1 = Pombo::Package::Item.new length: 2, height: 1, width: 1
      item2 = Pombo::Package::Item.new length: 3, height: 1, width: 1
      subject.items << item1
      subject.items << item2

      expect(subject.volume).to equal(item1.volume + item2.volume)
    end
  end

  describe '#weight' do
    it 'returns the sum of all items of the weight' do
      item1 = Pombo::Package::Item.new weight: 2
      item2 = Pombo::Package::Item.new weight: 3
      subject.items << item1
      subject.items << item2

      expect(subject.weight).to equal(item1.weight + item2.weight)
    end
  end

  describe '#diameter' do
    it 'returns zero if the package contains more than one item' do
      subject.add_item format: Pombo::Package::Format::ROLL, diameter: 5
      subject.add_item format: Pombo::Package::Format::ROLL, diameter: 5

      expect(subject.diameter).to equal(0)
    end

    it 'returns zero if the only item was not roll' do
      subject.add_item format: Pombo::Package::Format::PACKAGE, diameter: 5

      expect(subject.diameter).to equal(0)
    end

    it 'returns the diameter of the single item with roll format' do
      subject.add_item format: Pombo::Package::Format::ROLL, diameter: 5

      expect(subject.diameter).to equal(5)
    end
  end

  describe '#format' do
    it 'returns package format if the package contains more than one item' do
      subject.add_item format: Pombo::Package::Format::ROLL
      subject.add_item format: Pombo::Package::Format::ROLL

      expect(subject.format).to equal(Pombo::Package::Format::PACKAGE)
    end

    it 'returns the item format if the package contains only one item' do
      subject.add_item format: Pombo::Package::Format::ROLL

      expect(subject.format).to equal(Pombo::Package::Format::ROLL)
    end
  end

  describe '#add_item' do
    it 'returns the item added' do
      expect(subject.add_item(length: 1, height: 1, width: 1)).to be_a(Pombo::Package::Item)
    end

    include_examples 'updates_measures', :length

    include_examples 'updates_measures', :height

    include_examples 'updates_measures', :width

    context 'when there is an instance of an object item' do
      it 'receives the object and adds' do
        item = Pombo::Package::Item.new
        expect { subject.add_item(item) }.to change(subject.items, :size).by(1)
      end
    end

    context 'when you do not have an instance of an object item' do
      it 'receives the hash and add a new item' do
        expect {
          subject.add_item(length: 1, height: 1, width: 1)
        }.to change(subject.items, :size).by(1)
      end
    end
  end

end
