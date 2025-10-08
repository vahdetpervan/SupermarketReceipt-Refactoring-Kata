module Kata::Discounts
  class TenPercentDiscount
    def initialize(options = {})
      @product = options[:product]
      @argument = options[:argument]
      @unit_price = options[:unit_price]
      @quantity = options[:quantity]
    end

    def calculate(product, argument, unit_price, quantity)
      Kata::Discount.new(@product, @argument.to_s + "% off", @quantity * @unit_price * @argument / 100.0)
    end
  end
end