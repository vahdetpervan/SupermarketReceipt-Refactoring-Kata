module Kata::Discounts
  class TwoForAmount
    attr_reader :unit_price, :product

    def initialize(argument:, quantity:, unit_price:, product:)
      @argument = argument
      @quantity = quantity
      @unit_price = unit_price
      @product = product
    end

    def calculate
      total = @argument * (@quantity.to_i / 2) + @quantity.to_i % 2 * unit_price
      discount_n = unit_price * @quantity - total
      Kata::Discount.new(product, "2 for " + @argument.to_s, discount_n)
    end
  end
end