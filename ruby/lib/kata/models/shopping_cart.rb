class Kata::ShoppingCart
  attr_reader :items
  def initialize
    @items = []
    @product_quantities = Hash.new(0)
  end

  def add_item_quantity(product, quantity = 1)
    @items << Kata::ProductQuantity.new(product, quantity)
    return @product_quantities[product] += quantity

    @product_quantities[product] = quantity
  end

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)

      discount = offers[product].discount(quantity: quantity, unit_price: catalog.unit_price(product))
      receipt.add_discount(discount) if discount
    end
  end
end
