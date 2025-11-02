class Kata::Teller
  def initialize(catalog)
    @catalog = catalog
    @offers = {}
    @receipt = Kata::Receipt.new
  end

  def add_special_offer(offer_type, product, base_price) = @offers[product] = offer_for(offer_type, product, base_price)

  def checks_out_articles_from(the_cart)
    the_cart.each { |product, quantity| add_product_to_receipt(product.unit, product, quantity) }
    handle_offers(the_cart)
    @receipt
  end

  private

  def offer_for(offer_type, product, base_price)
    {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount.new({ product:, base_price: }),
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo.new({ product:, base_price: }),
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercentDiscount.new({ product:, base_price: }),
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount.new({ product:, base_price: })
    }[offer_type]
  end

  def add_product_to_receipt(product_unit, product, quantity)
    product_unit == Kata::ProductUnit::KILO ? handle_kilo(product, quantity) : handle_unit(product, quantity)
  end

  def handle_kilo(product, quantity)
    price = quantity * @catalog.unit_price(product)
    @receipt.add_product(product, quantity, @catalog.unit_price(product), price)
  end

  def handle_unit(product, quantity)
    quantity.times { @receipt.add_product(product, 1, @catalog.unit_price(product), @catalog.unit_price(product)) }
  end

  def handle_offers(the_cart)
    the_cart.select { |product, _| @offers.key?(product) }.each do |product, quantity|
      discount = @offers[product].calculate(unit_price: @catalog.unit_price(product), quantity:)
      @receipt.add_discount(discount) if discount
    end
  end
end
