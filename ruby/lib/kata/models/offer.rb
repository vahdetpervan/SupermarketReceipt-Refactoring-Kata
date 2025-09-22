class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def discount(quantity:, unit_price:)
    return Kata::TwoForAmount.new(argument:, quantity:, unit_price:, product:).build if offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
    return Kata::ThreeForTwo.new(quantity:, unit_price:, product:).build if offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
    return Kata::TenPercentDiscount.new(product:, argument:, quantity:, unit_price:).build if offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
    Kata::FiveForAmount.new(quantity:, unit_price:, argument:, product:).build if offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
  end
end
