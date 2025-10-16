class Kata::Teller

  def initialize(catalog)
    @catalog = catalog
    @offers = {}
    @receipt = Kata::Receipt.new
  end

  def add_special_offer(offer_type, product, argument) = @offers[product] = Kata::Offer.new(offer_type, product, argument)

  def checks_out_articles_from(the_cart)
    the_cart.product_quantities.each do |product, quantity|
      unit_price = @catalog.unit_price(product)
      price = quantity * unit_price
      @receipt.add_product(product, quantity, unit_price, price) if product.unit == Kata::ProductUnit::KILO
      quantity.times { @receipt.add_product(product, 1, unit_price, unit_price) } if product.unit == Kata::ProductUnit::EACH
    end
    the_cart.handle_offers(@receipt, @offers, @catalog)

    @receipt
  end

end
