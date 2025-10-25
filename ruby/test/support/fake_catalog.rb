class FakeCatalog < Kata::SupermarketCatalog
  def initialize = @products = {}

  def add_product(product, price) = @products[product.name] = price

  def unit_price(p) = @products.fetch(p.name)
end
