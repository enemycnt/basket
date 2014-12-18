require 'csv'
require_relative 'basket/version'

module Basket
  class Basket
    attr_accessor :items

    EXEMPT_LIST = %w(book chocolate pill)

    def initialize(path)
      @path = path
      csv_rows = CSV.read @path, :headers => true, :header_converters => :symbol, :col_sep => ", ", :converters => :all
      @items = []
      csv_rows.each do |row|
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
        result ||= EXEMPT_LIST.any?{|exemp| word.match(exemp)}
      end
      result
    end

    def sales_taxes
      @items.inject(0){ |sum, a| sum + a.tax }.round(2)
    end

    def price_sum
      @items.inject(0){ |sum, a| sum + a.price_gross }.round(2)
    end

    def export_to_csv
      export_path = @path.gsub(".csv", "_exported.csv")
      CSV.open(export_path, "wb") do |csv|
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
      raw_tax = (@amount * @price * ((sales_tax + import_tax) / 100))
      # round to nearest 0.05
      (raw_tax * 20).ceil / 20.0
    end

    def price_gross
      (@price + tax).round(2)
    end

    def import_tax
      imported? ? 5.0 : 0.0
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
