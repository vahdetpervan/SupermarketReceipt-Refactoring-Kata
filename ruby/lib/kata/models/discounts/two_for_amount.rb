module Kata::Discounts
  class TwoForAmount
    def initialize(options = {})
      @base_price = options[:base_price]
      @product = options[:product]
    end

    def calculate(quantity:, unit_price:)
      total = @base_price * (quantity / 2) + quantity % 2 * unit_price
      Kata::Discount.new(@product, "2 for #{@base_price}", unit_price * quantity - total)
    end
  end
end
