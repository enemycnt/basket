module Basket
  # Array with specific CSV export ability
  class ItemCollection < Array

    NAME_POSTFIX = "_exported.csv"

    def initialize(path)
      @path = path
    end

    def export_path
      @path.gsub(".csv", NAME_POSTFIX)
    end

    def add_item(row)
      self.push Item.for(row[:quantity], row[:product], row[:price])
    end

    def export_items(csv)
      self.each { |item| csv << [item.amount, item.name, item.price_gross] }
    end

  end
end