class Kata::Offer

  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def discount(quantity:, unit_price:)
    return discount_classes[@offer_type].new(argument:, product:).calculate(quantity:, unit_price:) if discount_classes[@offer_type]

    Kata::Discounts::ThreeForTwo.new({ product: }).calculate(quantity:, unit_price:)
  end

  private

  def discount_classes
    {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercent,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount
    }
  end
end
