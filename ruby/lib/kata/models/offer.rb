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
      return Kata::Discounts::TwoForAmount.new(argument:, quantity:, unit_price:, product:).calculate
    when Kata::SpecialOfferType::THREE_FOR_TWO
      return Kata::Discounts::ThreeForTwo.new(quantity:, unit_price:, product:).calculate
    end
    return Kata::Discounts::TenPercent.new(quantity:, unit_price:, argument:, product:).calculate if offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT

    Kata::Discounts::FiveForAmountDiscount.new(quantity:, unit_price:, argument:, product:).calculate if offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
  end
end
