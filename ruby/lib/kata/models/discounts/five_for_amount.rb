module Kata::Discounts
  class FiveForAmount
    def initialize(options = {})
      @product = options[:product]
      @argument = options[:argument]
      @base_price = options[:base_price]
    end

    def calculate(quantity:, unit_price:)
      return unless quantity.to_i >= 5

      discount_total = unit_price * quantity - (@argument * (quantity.to_i / 5) + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(@product, 5.to_s + " for " + @argument.to_s, discount_total)
    end
  end
end
