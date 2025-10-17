class Kata::ShoppingCart
  attr_reader :product_quantities

  def initialize = @product_quantities = Hash.new(0)

  def add_item_quantity(product, quantity) = product_quantities[product] += quantity
end
