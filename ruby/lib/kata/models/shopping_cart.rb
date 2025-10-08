class Kata::ShoppingCart
  attr_reader :items, :product_quantities

  def initialize
    @items = []
    @product_quantities = Hash.new(0)
  end

  def add_item_quantity(product, quantity = 1)
    @items << Kata::ProductQuantity.new(product, quantity)
    product_quantities[product] += quantity
  end

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)

      discount = two_for_amount_discount(offers, product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
      discount = three_for_two_discount(product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity.to_i > 2
      discount = ten_percent_discount(offers, product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      discount = five_for_amount_discount(offers, product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5

      receipt.add_discount(discount) if discount
    end
  end

  private

  def two_for_amount_discount(offers, product, unit_price, quantity)
    total = offers[product].argument * (quantity.to_i / 2) + quantity.to_i % 2 * unit_price
    discount_n = unit_price * quantity - total
    Kata::Discount.new(product, "2 for " + offers[product].argument.to_s, discount_n)
  end

  def three_for_two_discount(product, unit_price, quantity)
    discount_amount = quantity * unit_price - ((quantity.to_i / 3 * 2 * unit_price) + quantity.to_i % 3 * unit_price)
    Kata::Discount.new(product, "3 for 2", discount_amount)
  end

  def ten_percent_discount(offers, product, unit_price, quantity)
    Kata::Discount.new(product, offers[product].argument.to_s + "% off", quantity * unit_price * offers[product].argument / 100.0)
  end

  def five_for_amount_discount(offers, product, unit_price, quantity)
    discount_total = unit_price * quantity - (offers[product].argument * (quantity.to_i / 5) + quantity.to_i % 5 * unit_price)
    Kata::Discount.new(product, 5.to_s + " for " + offers[product].argument.to_s, discount_total)
  end

end
