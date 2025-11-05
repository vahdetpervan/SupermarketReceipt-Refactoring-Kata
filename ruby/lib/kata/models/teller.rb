class Kata::Teller
  def initialize(catalog)
    @catalog = catalog
    @offers = {}
    @bundles = []
    @receipt = Kata::Receipt.new
  end

  def add_special_offer(offer_type, product, base_price) = @offers[product] = offer_for(offer_type, product, base_price)
  def add_bundle(products, discount_amount) = @bundles << Kata::Discounts::Bundle.new({products:, catalog: @catalog, discount_amount:})

  def checks_out_articles_from(the_cart)
    the_cart.each { |product, quantity| add_product_to_receipt(product.unit, product, quantity) }
    handle_offers(the_cart)
    handle_bundles(the_cart)
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
    unit_price = @catalog.unit_price(product)
    return @receipt.add_product(product, quantity, unit_price, quantity * unit_price) if product_unit == Kata::ProductUnit::KILO

    quantity.times { @receipt.add_product(product, 1, unit_price, unit_price) }
  end

  def handle_offers(the_cart)
    the_cart.select { |product, _| @offers.key?(product) }.each do |product, quantity|
      discount = @offers[product].calculate(unit_price: @catalog.unit_price(product), quantity:)
      @receipt.add_discount(discount) if discount
    end
  end

  def handle_bundles(the_cart)
    @bundles.each do |bundle|
      result = the_cart.product_quantities.values.sum / bundle.products.size
      result.times { @receipt.add_bundle(bundle.calculate) }
    end
  end
end
