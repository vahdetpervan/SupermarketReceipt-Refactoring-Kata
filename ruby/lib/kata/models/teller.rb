class Kata::Teller
  def initialize(catalog)
    @catalog = catalog
    @offers = {}
    @receipt = Kata::Receipt.new
  end

  def add_special_offer(offer_type, product, argument) = @offers[product] = offer_for(offer_type, product, argument)

  def checks_out_articles_from(the_cart)
    the_cart.product_quantities.each { |product, quantity| handle_products(product.unit, product, quantity) }
    the_cart.handle_offers(@receipt, @offers, @catalog)
    @receipt
  end

  private

  def offer_for(offer_type, product, argument)
    {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercentDiscount,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount
    }[offer_type].new({ product:, argument: })
  end

  def handle_products(product_unit, *args)
    method_name = {
      Kata::ProductUnit::KILO => :handle_kilo,
      Kata::ProductUnit::EACH => :handle_unit,
    }[product_unit]
    send(method_name, *args)
  end

  def handle_kilo(product, quantity)
    price = quantity * @catalog.unit_price(product)
    @receipt.add_product(product, quantity, @catalog.unit_price(product), price)
  end

  def handle_unit(product, quantity)
    quantity.times { @receipt.add_product(product, 1, @catalog.unit_price(product), @catalog.unit_price(product)) }
  end
end
