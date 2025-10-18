class Kata::Discount
  attr_reader :product, :description, :discount_amount

  def initialize(product, description, discount_amount)
    @product = product
    @description = description
    @discount_amount = discount_amount
  end

  def product_name
    @product.name
  end
end
