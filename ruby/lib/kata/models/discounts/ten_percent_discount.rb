module Kata::Discounts
  class TenPercentDiscount
    def calculate(product, argument, unit_price, quantity)
      Kata::Discount.new(product, argument.to_s + "% off", quantity * unit_price * argument / 100.0)
    end
  end
end