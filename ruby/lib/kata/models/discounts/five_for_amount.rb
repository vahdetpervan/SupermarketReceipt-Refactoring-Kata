module Kata::Discounts
  class FiveForAmount
    def initialize(options = {}, argument: nil, product: nil)
      @argument = argument
      @product = product
    end

    def calculate(quantity:, unit_price:)
      return unless quantity.to_i >= 5

      item_units_for_discount = quantity.to_i / 5
      discount_total = unit_price * quantity - (@argument * item_units_for_discount + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(@product, 5.to_s + " for " + @argument.to_s, discount_total)
    end
  end
end
