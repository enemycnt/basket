require_relative 'item'
require_relative 'exempt_item'
require_relative 'item_collection'

module Basket
  # The main class basket that contains other items
  class Basket

    attr_accessor :items

    def initialize(path)
      csv_rows = CSV.read path,
                          :headers => true,
                          :header_converters => :symbol,
                          :col_sep => ", ",
                          :converters => :all
      @items = ItemCollection.new(path)
      csv_rows.each { |row| @items.add_item row }
    end

    def sales_taxes
      @items.inject(0){ |sum, item| sum + item.tax }.round(2)
    end

    def price_sum
      @items.inject(0){ |sum, item| sum + item.price_gross }.round(2)
    end

    def export_to_csv
      CSV.open(@items.export_path, "wb") do |csv|
        @items.export_items csv
        add_footer csv
      end
    end

    def add_footer(csv)
      # Empty row
      csv << [" ", " "]
      # Total and sales taxes
      csv << ["Sales Taxes:", sales_taxes]
      csv << ["Total:", price_sum]
    end
  end
end
