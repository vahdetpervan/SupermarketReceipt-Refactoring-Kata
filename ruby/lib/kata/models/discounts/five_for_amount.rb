module Kata::Discounts
  class FiveForAmount
    def calculate(offers, product, unit_price, quantity, argument = nil)
      return unless quantity.to_i >= 5

      discount_total = unit_price * quantity - (offers[product].argument * (quantity.to_i / 5) + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(product, 5.to_s + " for " + offers[product].argument.to_s, discount_total)
    end
  end
end
