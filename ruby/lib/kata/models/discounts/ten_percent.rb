module Kata::Discounts
  class TenPercent
    def initialize(options = {})
      @argument = options[:argument]
      @product = options[:product]
    end

    def calculate(quantity:, unit_price:)
      Kata::Discount.new(@product, @argument.to_s + "% off", quantity * unit_price * @argument / 100.0)
    end
  end
end
