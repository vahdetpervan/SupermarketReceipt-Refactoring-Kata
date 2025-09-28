module Kata::Discounts
  class ThreeForTwo
    attr_reader :quantity, :unit_price, :product
    def initialize(quantity:, unit_price:, product:)
      @quantity = quantity
      @unit_price = unit_price
      @product = product
    end
  end
end
