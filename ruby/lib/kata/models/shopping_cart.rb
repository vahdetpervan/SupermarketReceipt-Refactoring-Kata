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
      discount = three_for_two_discount(product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
      discount = ten_percent_discount(offers, product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      discount = five_for_amount_discount(offers, product, catalog.unit_price(product), quantity) if offers[product].offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT

      receipt.add_discount(discount) if discount
    end
  end

  private

  def two_for_amount_discount(offers, product, unit_price, quantity)
    Kata::Discounts::TwoForAmount.new({offers:, product:, unit_price:, quantity:, argument: offers[product].argument}).calculate
  end

  def three_for_two_discount(product, unit_price, quantity)
    Kata::Discounts::ThreeForTwo.new({ product:, unit_price:, quantity: }).calculate
  end

  def ten_percent_discount(offers, product, unit_price, quantity)
    Kata::Discounts::TenPercentDiscount.new({ product:, argument: offers[product].argument, unit_price:, quantity: }).calculate
  end

  def five_for_amount_discount(offers, product, unit_price, quantity)
    Kata::Discounts::FiveForAmount.new.calculate(product, offers[product].argument, unit_price, quantity)
  end

end
