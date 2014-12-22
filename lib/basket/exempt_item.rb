module Basket
  # Exempt item with zero sales tax
  class ExemptItem < Item

    def sales_tax
      0.0
    end

  end
end

