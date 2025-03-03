class Kata::ShoppingCart

  def initialize
    @items = []
    @product_quantities = {}
  end

  def items
    Array.new @items
  end

  def add_item(product)
    add_item_quantity(product, 1.0)
    nil
  end

  def product_quantities
    @product_quantities
  end

  def add_item_quantity(product, quantity)
    @items << Kata::ProductQuantity.new(product, quantity)
    if @product_quantities.key?(product)
      product_quantities[product] = product_quantities[product] + quantity
    else
      product_quantities[product] = quantity
    end
  end

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)
      offer = offers[product]

      if offer.offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
        discount = offer.handle(quantity: quantity, unit_price: catalog.unit_price(product))
      end
      if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
        discount = offer.handle(quantity: quantity, unit_price: catalog.unit_price(product))
      end
      if offer.offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
        discount = offer.handle(quantity: quantity, unit_price: catalog.unit_price(product))
      end
      if offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
        discount = offer.handle(quantity: quantity, unit_price: catalog.unit_price(product))
      end
      receipt.add_discount(discount) if discount
    end
  end

end
