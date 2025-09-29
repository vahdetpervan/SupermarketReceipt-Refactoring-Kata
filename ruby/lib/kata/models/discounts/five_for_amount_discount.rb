module Kata::Discounts
  class FiveForAmountDiscount
    attr_reader :quantity, :unit_price, :argument, :product

    def initialize(quantity:, unit_price:, argument:, product:)
      @quantity = quantity
      @unit_price = unit_price
      @argument = argument
      @product = product
    end

    def calculate
      item_units_for_discount = @quantity.to_i / 5
      discount_total = @unit_price * @quantity - (argument * item_units_for_discount + @quantity.to_i % 5 * @unit_price)
      Kata::Discount.new(product, 5.to_s + " for " + argument.to_s, discount_total)
    end
  end
end
