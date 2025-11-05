module Kata::Discounts
  class Bundle
    attr_reader :products
    def initialize(options = {})
      @products = options[:products]
      @catalog = options[:catalog]
      @discount_amount = options[:discount_amount]
    end

    def calculate = Kata::Discount.new(@products, "Bundle", product_prices.sum * @discount_amount / 100)

    private

    def product_prices = @catalog.products.values_at(*product_names)
    def product_names = @products.map(&:name)
  end
end
