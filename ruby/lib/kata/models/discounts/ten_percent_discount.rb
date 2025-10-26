module Kata::Discounts
  class TenPercentDiscount
    def initialize(options = {})
      @product = options[:product]
      @base_price = options[:base_price]
    end

    def calculate(quantity:, unit_price:)
      Kata::Discount.new(@product, "#{@base_price}% off", quantity * unit_price * @base_price / 100.0)
    end
  end
end
