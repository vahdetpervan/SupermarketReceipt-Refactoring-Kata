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
      if offers.key?(product)
        unit_price = catalog.unit_price(product)
        x = 1
        x = 3 if offers[product].offer_type == Kata::SpecialOfferType::THREE_FOR_TWO

        if offers[product].offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT && quantity.to_i >= 2
          total = offers[product].argument * (quantity.to_i / 2) + quantity.to_i % 2 * unit_price
          discount_n = unit_price * quantity - total
          discount = Kata::Discount.new(product, "2 for " + offers[product].argument.to_s, discount_n)
        end

        x = 5 if offers[product].offer_type == Kata::SpecialOfferType:: FIVE_FOR_AMOUNT

        number_of_x = quantity.to_i / x
        if offers[product].offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity.to_i > 2
          discount_amount = quantity * unit_price - ((number_of_x * 2 * unit_price) + quantity.to_i % 3 * unit_price)
          discount = Kata::Discount.new(product, "3 for 2", discount_amount)
        end
        if offers[product].offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
          discount = Kata::Discount.new(product, offers[product].argument.to_s + "% off", quantity * unit_price * offers[product].argument / 100.0)
        end
        if offers[product].offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
          discount_total = unit_price * quantity - (offers[product].argument * number_of_x + quantity.to_i % 5 * unit_price)
          discount = Kata::Discount.new(product, x.to_s + " for " + offers[product].argument.to_s, discount_total)
        end

        receipt.add_discount(discount) if discount
      end
    end
  end

end
