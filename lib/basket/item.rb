module Basket
  # Standard item
  class Item
    attr_accessor :amount, :name, :price, :price_gross, :tax

    EXEMPT_LIST = %w(book chocolate pill)

    def initialize(amount, name, price)
      @amount = amount
      @name = name
      @price = price
    end

    def self.for(*args)
      klass = is_exemp?(*args[1]) ? ExemptItem : Item
      klass.new *args
    end

    def self.is_exemp?(product_name)
      product_name.split(' ').detect do |word|
        EXEMPT_LIST.any?{|exemp| word.match(exemp)}
      end
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

end