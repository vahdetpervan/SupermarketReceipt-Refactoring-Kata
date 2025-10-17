module Kata::Discounts
  class TwoForAmount
    def initialize(options = {})
      @argument = options[:argument]
      @product = options[:product]
      @unit_price = options[:unit_price]
      @quantity = options[:quantity]
    end

    def calculate(quantity: nil, unit_price: nil)
      total = @argument * (@quantity.to_i / 2) + @quantity.to_i % 2 * @unit_price
      discount_n = @unit_price * @quantity - total
      Kata::Discount.new(@product, "2 for " + @argument.to_s, discount_n)
    end
  end
end
