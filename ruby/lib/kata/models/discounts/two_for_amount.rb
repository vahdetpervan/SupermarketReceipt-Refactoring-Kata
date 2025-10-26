module Kata::Discounts
  class TwoForAmount
    def initialize(options = {})
      @base_price = options[:base_price]
      @product = options[:product]
    end

    def calculate(quantity:, unit_price:)
      total = @base_price * (quantity.to_i / 2) + quantity.to_i % 2 * unit_price
      discount_n = unit_price * quantity - total
      Kata::Discount.new(@product, "2 for #{@base_price}", discount_n)
    end
  end
end
