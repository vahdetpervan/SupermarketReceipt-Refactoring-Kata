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
        total = offer.argument * (quantity.to_i / 2) + quantity.to_i % 2 * catalog.unit_price(product)
        discount_n = catalog.unit_price(product) * quantity - total
        discount = Kata::Discount.new(product, "2 for " + offer.argument.to_s, discount_n)
      end
      if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
        item_units_for_discount = quantity.to_i / 3
        discount_amount = quantity * catalog.unit_price(product) - ((item_units_for_discount * 2 * catalog.unit_price(product)) + quantity.to_i % 3 * catalog.unit_price(product))
        discount = Kata::Discount.new(product, "3 for 2", discount_amount)
      end
      if offer.offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
        discount = Kata::Discount.new(product, offer.argument.to_s + "% off", quantity * catalog.unit_price(product) * offer.argument / 100.0)
      end
      if offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
        item_units_for_discount = quantity.to_i / 5
        discount_total = catalog.unit_price(product) * quantity - (offer.argument * item_units_for_discount + quantity.to_i % 5 * catalog.unit_price(product))
        discount = Kata::Discount.new(product, 5.to_s + " for " + offer.argument.to_s, discount_total)
      end
      receipt.add_discount(discount) if discount
    end
  end

end
