require_relative 'spec_helper'
require_relative '../lib/basket'

describe Basket::Basket do
  before :each do
    @basket = Basket::Basket.new 'data/input1.csv'
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

  describe "#export_to_csv" do
    it "creates csv file" do
      @basket.export_to_csv
      expect(File).to exist('data/input1_exported.csv')
    end

  end

end


