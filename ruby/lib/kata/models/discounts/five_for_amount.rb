module Kata::Discounts
  class FiveForAmount
    def calculate(product, argument, unit_price, quantity)
      return unless quantity.to_i >= 5

      discount_total = unit_price * quantity - (argument * (quantity.to_i / 5) + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(product, 5.to_s + " for " + argument.to_s, discount_total)
    end
  end
end
