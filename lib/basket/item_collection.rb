module Basket
  # Array with specific CSV export ability
  class ItemCollection < Array

    NAME_POSTFIX = "_exported.csv"

    def initialize(path, basket)
      @path = path
      @basket = basket
    end

    def export_to_csv
      CSV.open(export_path, "wb") do |csv|
        add_items csv
        add_footer csv
      end
    end

    def export_path
      @path.gsub(".csv", NAME_POSTFIX)
    end

    def add_items(csv)
      self.each { |item| csv << [item.amount, item.name, item.price_gross] }
    end

    def add_footer(csv )
      # Empty row
      csv << [" ", " "]
      # Total and sales taxes
      csv << ["Sales Taxes:", @basket.sales_taxes]
      csv << ["Total:", @basket.price_sum]
    end

  end
end