module Kata::Discounts
  class TwoForAmount
    attr_reader :amount, :quantity, :unit_price, :product

    def initialize(argument:, quantity:, unit_price:, product:)
      @argument = argument
      @quantity = quantity
      @unit_price = unit_price
      @product = product
    end

    def calculate

    end
  end
end