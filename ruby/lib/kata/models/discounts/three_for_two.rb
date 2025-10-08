module Kata::Discounts
  class ThreeForTwo
    def initialize(options = {})
      @product = options[:product]
      @unit_price = options[:unit_price]
      @quantity = options[:quantity]
    end

    def calculate
      discount_amount = @quantity * @unit_price - ((@quantity.to_i / 3 * 2 * @unit_price) + @quantity.to_i % 3 * @unit_price)
      Kata::Discount.new(@product, "3 for 2", discount_amount)
    end
  end
end