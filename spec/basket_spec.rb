require_relative 'spec_helper'
require_relative '../lib/basket'



describe Basket::Item do
  before :each do
    @item = Basket::Item.new 1, "music cd", 14.99
  end

  describe "#new" do
    it "takes three parameters and returns a Item object" do
      @item.should be_an_instance_of Basket::Item
    end
  end

  describe "#tax" do
    it "returns correct tax" do
      @item.tax.should eq(1.5)
    end
  end

  describe "#price" do
    it "returns price with taxes" do
      @item.price.should eq(16.49)
    end
  end

end

describe Basket::ExemptItem do
  before :each do
    @item = Basket::ExemptItem.new 1, "music cd", 14.99
  end

  describe "#new" do
    it "takes three parameters and returns a Item object" do
      @item.should be_an_instance_of Basket::ExemptItem
    end
  end

  describe "#tax" do
    it "returns correct tax" do
      @item.tax.should eq(0.0)
    end
  end

  describe "#price" do
    it "returns price with taxes" do
      @item.price.should eq(14.99)
    end
  end
end
