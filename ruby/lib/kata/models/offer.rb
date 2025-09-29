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
      return Kata::Discounts::TwoForAmount.new(argument:, product:).calculate(quantity:, unit_price:)
    when Kata::SpecialOfferType::THREE_FOR_TWO
      return Kata::Discounts::ThreeForTwo.new(quantity:, unit_price:, product:).calculate(quantity:, unit_price:)
    when Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      return Kata::Discounts::TenPercent.new(quantity:, unit_price:, argument:, product:).calculate
    when Kata::SpecialOfferType::FIVE_FOR_AMOUNT
      Kata::Discounts::FiveForAmountDiscount.new(quantity:, unit_price:, argument:, product:).calculate if quantity.to_i >= 5
    end
  end
end
