require_relative 'item'
require_relative 'exempt_item'

module Basket
  #The main class basket that contains other items
  class Basket
    attr_accessor :items

    def initialize(path)
      @path = path
      csv_rows = CSV.read @path,
                          :headers => true,
                          :header_converters => :symbol,
                          :col_sep => ", ",
                          :converters => :all
      @items = []
      csv_rows.each do |row|
        @items.push Item.for(row[:quantity], row[:product], row[:price])
      end
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
end
