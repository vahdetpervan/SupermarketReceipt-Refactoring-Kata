module Kata::Discounts
  class TenPercent
    attr_reader :quantity, :unit_price, :argument, :product

    def initialize(quantity:, unit_price:, argument:, product:)
      @quantity = quantity
      @unit_price = unit_price
      @argument = argument
      @product = product
    end

    def calculate
      Kata::Discount.new(product, argument.to_s + "% off", @quantity * @unit_price * argument / 100.0)
    end
  end
end
