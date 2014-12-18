require 'csv'
require "basket/version"

module Basket
  # Your code goes here...
  class Basket
    attr_accessor :items
    def initialize
      path = '/Users/nick/Projects/basket/data/input1.csv'
      arr = CSV.read path, :headers => true, :header_converters => :symbol, :col_sep => ", ", :converters => :all
      arr.each do |row|
        puts row.inspect
      end
    end
  end

  class Item
    attr_accessor :amount, :name, :price

    def initialize(amount, name, price)
      @amount = amount
      @name = name
      @price = price
    end

    def sales_tax
      10.0
    end

    def tax
      (@amount * @price * ((sales_tax + import_tax) / 100)).round(2)
    end

    def price
      (@price + tax).round(2)
    end

    def import_tax
      imported? ? 0.05 : 0.00
    end

    def imported?
      @name.include?("imported ")
    end
  end

  class ExemptItem < Item

    def sales_tax
      0.0
    end

  end



end
