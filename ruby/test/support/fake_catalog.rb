class FakeCatalog < Kata::SupermarketCatalog
  def initialize
    @products = {}
  end

  def add_product(product, price)
    @products[product.name] = price
  end

  def unit_price(p)
    @products.fetch(p.name)
  end
end
