require_relative 'spec_helper'
require_relative '../lib/basket'

describe Basket::Basket do
  before :each do
    @basket = Basket::Basket.new '/Users/nick/Projects/basket/data/input1.csv'
  end

  describe "#new" do
    it "takes path parametr and returns a Basket object" do
      expect(@basket).to be_an_instance_of Basket::Basket
    end
  end

  describe "#sales_taxes" do
    it "returns sum of taxes" do
      expect(@basket.sales_taxes).to eq(1.5)
    end
  end

  describe "#price_sum" do
    it "returns sum of gross prices" do
      expect(@basket.price_sum).to eq(29.83)
    end
  end

end

describe Basket::Item do
  before :each do
    @item = Basket::Item.new 1, "music cd", 14.99
  end

  describe "#new" do
    it "takes three parameters and returns an Item object" do
      expect(@item).to be_an_instance_of Basket::Item
    end
  end

  describe "#tax" do
    it "returns correct tax" do
      expect(@item.tax).to eq(1.5)
    end
  end

  describe "#price" do
    it "returns price with taxes" do
      expect(@item.price_gross).to eq(16.49)
    end
  end

end

describe Basket::ExemptItem do
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
