require_relative 'item'
require_relative 'exempt_item'
require_relative 'item_collection'

module Basket
  #The main class basket that contains other items
  class Basket
    attr_accessor :items
    NAME_POSTFIX = "_exported.csv"
    def initialize(path)
      # @path = path
      csv_rows = CSV.read path,
                          :headers => true,
                          :header_converters => :symbol,
                          :col_sep => ", ",
                          :converters => :all
      # @items = []
      @items = ItemCollection.new(path, self)
      csv_rows.each do |row|
        @items.push Item.for(row[:quantity], row[:product], row[:price])
      end
    end

    def sales_taxes
      @items.inject(0){ |sum, item| sum + item.tax }.round(2)
    end

    def price_sum
      @items.inject(0){ |sum, item| sum + item.price_gross }.round(2)
    end

    def export_to_csv
      @items.export_to_csv
    end
  end
end
