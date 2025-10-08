module Kata::Discounts
  class TenPercentDiscount
    def calculate(offers, product, unit_price, quantity, argument = nil)
      Kata::Discount.new(product, argument.to_s + "% off", quantity * unit_price * argument / 100.0)
    end
  end
end