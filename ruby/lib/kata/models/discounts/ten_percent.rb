module Kata::Discounts
  class TenPercent
    def initialize(options = {}, argument: nil, product: nil)
      @argument = argument
      @product = product
    end

    def calculate(quantity:, unit_price:)
      Kata::Discount.new(@product, @argument.to_s + "% off", quantity * unit_price * @argument / 100.0)
    end
  end
end
