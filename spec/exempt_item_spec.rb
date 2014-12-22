require_relative 'spec_helper'
require_relative '../lib/basket'

describe Basket::ExemptItem do
  context "usual exempt" do
    before :each do
      @item = Basket::ExemptItem.new 1, "music cd", 14.99
    end

    describe "#new" do
      it "takes three parameters and returns an ExemptItem object" do
        expect(@item).to be_an_instance_of Basket::ExemptItem
      end
    end

    describe "#tax" do
      it "returns correct tax" do
        expect(@item.tax).to eq(0.0)
      end
    end

    describe "#price" do
      it "returns price with taxes" do
        expect(@item.price_gross).to eq(14.99)
      end
    end

    describe "#imported?" do
      it "returns true or false depends of imported status" do
        expect(@item.imported?).to be false
      end
    end

    describe "import_tax" do
      it "returns imported tax" do
        expect(@item.import_tax).to eq(0.0)
      end
    end
  end

  context "imported and exempt" do
    before :each do
      @item = Basket::ExemptItem.new 1, "box of imported chocolates", 11.25
    end

    describe "#tax" do
      it "returns correct tax" do
        expect(@item.tax).to eq(0.6)
      end
    end

    describe "#price" do
      it "returns price with taxes" do
        expect(@item.price_gross).to eq(11.85)
      end
    end

    describe "#imported?" do
      it "returns true or false depends of imported status" do
        expect(@item.imported?).to be true
      end
    end

    describe "import_tax" do
      it "returns imported tax" do
        expect(@item.import_tax).to eq(5)
      end
    end
  end
end