class Kata::Teller

  def initialize(catalog)
    @catalog = catalog
    @offers = {}
    @receipt = Kata::Receipt.new
  end

  def add_special_offer(offer_type, product, argument) = @offers[product] = Kata::Offer.new(offer_type, product, argument)

  def checks_out_articles_from(the_cart)
    the_cart.product_quantities.each do |product, quantity|
      price = quantity * @catalog.unit_price(product)
      @receipt.add_product(product, quantity, @catalog.unit_price(product), price) if product.unit == Kata::ProductUnit::KILO
      quantity.times { @receipt.add_product(product, 1, @catalog.unit_price(product), @catalog.unit_price(product)) } if product.unit == Kata::ProductUnit::EACH
    end
    the_cart.handle_offers(@receipt, @offers, @catalog)
    @receipt
  end

  private

  def offers
    {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercentDiscount,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount
    }
  end
end
