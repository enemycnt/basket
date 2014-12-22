require_relative 'spec_helper'
require_relative '../lib/basket'

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

  describe "#is_exemp?" do
    it "check for exemption" do
      expect(Basket::Item.is_exemp?("box of chocolates")).not_to be false
    end

    it "check for exemption" do
      expect(Basket::Item.is_exemp?("imported box of book")).not_to be false
    end

    it "check for exemption" do
      expect(Basket::Item.is_exemp?("imported box of nothing")).to be nil
    end
  end

  describe "#for" do
    it "returns Item instance" do
      @item = Basket::Item.for(1, "music cd", 14.99)
      expect(@item).to be_an_instance_of Basket::Item
    end

    it "returns ExtempItem instance" do
      @item = Basket::Item.for(1, "skary book", 14.99)
      expect(@item).to be_an_instance_of Basket::ExemptItem
    end

  end

end