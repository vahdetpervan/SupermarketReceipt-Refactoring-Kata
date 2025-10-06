class Kata::Offer
  def initialize(offer_type, product, argument)
    @discount = {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercent,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo
    }[offer_type].new({ argument:, product: })
  end

  def discount(quantity:, unit_price:)
    @discount.calculate(quantity:, unit_price:)
  end
end
