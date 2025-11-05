class FakeCatalog < Kata::SupermarketCatalog
  attr_reader :products
  def initialize = @products = {}

  def add_product(product, price) = @products[product.name] = price

  def unit_price(product) = @products.fetch(product.name)
end
