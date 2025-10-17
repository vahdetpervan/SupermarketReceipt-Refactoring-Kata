class Kata::ShoppingCart
  attr_reader :product_quantities

  def initialize
    @product_quantities = Hash.new(0)
  end

  def add_item_quantity(product, quantity) = product_quantities[product] += quantity

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)

      discount = offers[product].calculate(unit_price: catalog.unit_price(product), quantity:)
      receipt.add_discount(discount) if discount
    end
  end
end
