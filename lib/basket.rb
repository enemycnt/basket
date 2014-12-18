require 'csv'
require_relative 'basket/version'

module Basket
  # Your code goes here...
  class Basket
    attr_accessor :items

    EXEMPT_LIST = %w(book chocolate pill)

    def initialize(path)

      # path = '/Users/nick/Projects/basket/data/input1.csv'
      arr = CSV.read path, :headers => true, :header_converters => :symbol, :col_sep => ", ", :converters => :all
      @items = []
      arr.each do |row|
        if is_exemp?(row[:product])
          @items.push ExemptItem.new(row[:quantity], row[:product], row[:price])
        else
          @items.push Item.new(row[:quantity], row[:product], row[:price])
        end
      end
    end

    def is_exemp?(product_name)
      result = false
      words_list = product_name.split(' ')
      words_list.each do |word|
        result ||= EXEMPT_LIST.any?{|exemp| exemp.match(word)}
      end
      result
    end

    def sales_taxes
      @items.inject(0){ |sum, a| sum + a.tax }.round(2)
    end

    def price_sum
      @items.inject(0){ |sum, a| sum + a.price_gross }
    end

    def export_to_csv
      CSV.open("data/export.csv", "wb") do |csv|
        @items.each do |item|
          csv << [item.amount, item.name, item.price_gross]
        end
        # Empty row
        csv << [" ", " "]
        # Total and sales taxes
        csv << ["Sales Taxes:", sales_taxes]
        csv << ["Total:", price_sum]
      end
    end
  end

  class Item
    attr_accessor :amount, :name, :price, :price_gross, :tax

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

    def price_gross
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
