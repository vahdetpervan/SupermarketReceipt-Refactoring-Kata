class Kata::ShoppingCart
  attr_reader :product_quantities

  def initialize
    @product_quantities = Hash.new(0)
    @discount_classes = {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercentDiscount,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount
    }.freeze
  end

  def add_item_quantity(product, quantity) = product_quantities[product] += quantity

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)

      if @discount_classes.values.any? { |klass| offers[product].is_a?(klass) }
        discount = offers[product].calculate(unit_price: catalog.unit_price(product), quantity:)
      end

      receipt.add_discount(discount) if discount
    end
  end
end
