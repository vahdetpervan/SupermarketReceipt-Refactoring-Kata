module Kata::Discounts
  class FiveForAmount
    def initialize(options = {})
      @product = options[:product]
      @base_price = options[:base_price]
    end

    def calculate(quantity:, unit_price:)
      return unless quantity.to_i >= 5

      discount_total = unit_price * quantity - (@base_price * (quantity.to_i / 5) + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(@product, "5 for #{@base_price}", discount_total)
    end
  end
end
