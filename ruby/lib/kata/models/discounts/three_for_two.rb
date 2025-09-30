module Kata::Discounts
  class ThreeForTwo
    def initialize(options = {})
      @product = options[:product]
    end

    def calculate(quantity:, unit_price:)
      item_units_for_discount = quantity.to_i / 3
      discount_amount = quantity * unit_price - ((item_units_for_discount * 2 * unit_price) + quantity.to_i % 3 * unit_price)
      Kata::Discount.new(@product, "3 for 2", discount_amount)
    end
  end
end
