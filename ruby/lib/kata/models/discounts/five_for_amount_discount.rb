module Kata::Discounts
  class FiveForAmountDiscount
    attr_reader :argument, :product

    def initialize(quantity: nil, unit_price: nil, argument:, product:)
      @argument = argument
      @product = product
    end

    def calculate(quantity:, unit_price:)
      item_units_for_discount = quantity.to_i / 5
      discount_total = unit_price * quantity - (argument * item_units_for_discount + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(product, 5.to_s + " for " + argument.to_s, discount_total)
    end
  end
end
