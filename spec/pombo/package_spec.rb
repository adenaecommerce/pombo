require 'spec_helper'

describe Pombo::Package do
  shared_examples 'updates_measures' do |property|
    context 'When it contains only one item' do
      it "updates #{ property }" do
        item = { length: 1, height: 5, width: 5 }
        subject.add_item item
        expect(subject.send(property)).to eq(item[property])
      end
    end

    context 'When contain more than one item' do
      it "updates #{ property }" do
        subject.add_item length: 1, height: 5, width: 5
        subject.add_item length: 2, height: 5, width: 5
        expect(subject.send(property)).to eq(Math.cbrt(subject.volume))
      end
    end
  end

  %i[in_hand delivery_notice].each do |method|
    describe "##{ method }?" do
      it { is_expected.to respond_to "#{ method }?" }
    end
  end

  %i[in_hand delivery_notice].each do |method|
    describe "##{ method }=" do
      it 'throw exception not boolean values' do
        expect { subject.send("#{ method }=", 'anything') }.to raise_error TypeError
      end
    end
  end

  %i[length height width].each do |method|
    describe "##{ method }" do
      let(:measures) { { weight: 10, length: 15, height: 2, width: 10 } }
      let(:format) { Pombo::Package::Format.find(subject.format) }
      before { subject.add_item weight: measures[:weight] , length: measures[:length], height: measures[:height], width: measures[:width] }

      context "when min_package is false" do
        it 'returns its measures' do
          Pombo.set min_package: false

          expect(subject.send(method)).to eq(measures[method])
        end
      end

      context "when min_package is true" do
        it 'returns the measures of the format' do
          Pombo.set min_package: true

          expect(subject.send(method)).to eq(format.send("min_#{ method }"))
        end
      end
    end
  end

  describe '#services=' do
    it 'allows informing the code of a single service' do
      service_code = Pombo::Services.all(:pac).first.code
      expect { subject.services = service_code }.to change(subject, :services).to([service_code])
    end

    it 'allows informing multiple services' do
      service_code1 = Pombo::Services.all(:pac).first.code
      service_code2 = Pombo::Services.all(:sedex).first.code
      expect { subject.services = [service_code1, service_code2] }.to change(subject, :services).to([service_code1, service_code2])
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

  describe '#single_item?' do
    it 'returns true if there is only one item in a quantity' do
      subject.add_item quantity: 1
      expect(subject.single_item?).to be_truthy
    end

    it 'returns false if there is an item with more than one quantity' do
      subject.add_item quantity: 2
      expect(subject.single_item?).to be_falsy
    end

    it 'returns false if there is more than one item' do
      subject.add_item quantity: 1
      subject.add_item quantity: 1
      expect(subject.single_item?).to be_falsy
    end
  end

  describe '#diameter' do
    it 'returns zero if the package contains more than one item' do
      subject.add_item format: Pombo::Package::Format.find(:roll).code, diameter: 5
      subject.add_item format: Pombo::Package::Format.find(:roll).code, diameter: 5

      expect(subject.diameter).to equal(0)
    end

    it 'returns zero if the only item was not roll' do
      subject.add_item format: Pombo::Package::Format.find(:box).code, diameter: 5

      expect(subject.diameter).to equal(0)
    end

    it 'returns the diameter of the single item with roll format' do
      subject.add_item format: Pombo::Package::Format.find(:roll).code, diameter: 5

      expect(subject.diameter).to equal(5)
    end
  end

  describe '#format' do
    it 'returns package format if the package contains more than one item' do
      subject.add_item format: Pombo::Package::Format.find(:roll).code
      subject.add_item format: Pombo::Package::Format.find(:roll).code

      expect(subject.format).to equal(Pombo::Package::Format.find(:box).code)
    end

    it 'returns the item format if the package contains only one item' do
      subject.add_item format: Pombo::Package::Format.find(:box).code

      expect(subject.format).to equal(Pombo::Package::Format.find(:box).code)
    end
  end

  describe '#add_item' do
    before { Pombo.set min_package: false }

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
