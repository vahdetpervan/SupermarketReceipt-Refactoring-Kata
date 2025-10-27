class Kata::ShoppingCart
  attr_reader :product_quantities

  def initialize = @product_quantities = Hash.new(0)

  def add_item(product, quantity) = product_quantities[product] += quantity

  def each(&block)
    @product_quantities.each(&block)
  end
end
