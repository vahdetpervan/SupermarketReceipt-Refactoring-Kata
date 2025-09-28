module Kata::Discounts
  class FiveForAmountDiscount
    def initialize(quantity:, unit_price:, argument:, product:)
      @quantity = quantity
      @unit_price = unit_price
      @argument = argument
      @product = product
    end
  end
end
