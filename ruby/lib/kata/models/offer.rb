class Kata::Offer

  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def discount(quantity:, unit_price:)
    case @offer_type
    when Kata::SpecialOfferType::TWO_FOR_AMOUNT
      Kata::Discounts::TwoForAmount.new(argument:, product:).calculate(quantity:, unit_price:)
    when Kata::SpecialOfferType::THREE_FOR_TWO
      Kata::Discounts::ThreeForTwo.new(product:).calculate(quantity:, unit_price:)
    when Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      Kata::Discounts::TenPercent.new(argument:, product:).calculate(quantity:, unit_price:)
    when Kata::SpecialOfferType::FIVE_FOR_AMOUNT
      Kata::Discounts::FiveForAmount.new(argument:, product:).calculate(quantity:, unit_price:)
    end
  end
end
