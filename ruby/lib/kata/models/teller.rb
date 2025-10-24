class Kata::Teller
  def initialize(catalog)
    @catalog = catalog
    @offers = {}
    @receipt = Kata::Receipt.new
  end

  def add_special_offer(offer_type, product, base_price) = @offers[product] = offer_for(offer_type, product, base_price)

  def checks_out_articles_from(the_cart)
    the_cart.product_quantities.each { |product, quantity| add_product_to_receipt(product.unit, product, quantity) }
    handle_offers(the_cart)
    @receipt
  end

  private

  def offer_for(offer_type, product, base_price)
    {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercentDiscount,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount
    }[offer_type].new({ product:, argument: base_price, base_price: })
  end

  def add_product_to_receipt(product_unit, *args)
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

  def handle_offers(the_cart)
    the_cart.product_quantities.each do |product, quantity|
      next unless @offers.key?(product)

      discount = @offers[product].calculate(unit_price: @catalog.unit_price(product), quantity:)
      @receipt.add_discount(discount) if discount
    end
  end
end
