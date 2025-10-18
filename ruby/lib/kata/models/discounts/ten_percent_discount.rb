module Kata::Discounts
  class TenPercentDiscount
    def initialize(options = {})
      @product = options[:product]
      @argument = options[:argument]
    end

    def calculate(quantity:, unit_price:)
      Kata::Discount.new(@product, @argument.to_s + "% off", quantity * unit_price * @argument / 100.0)
    end
  end
end
