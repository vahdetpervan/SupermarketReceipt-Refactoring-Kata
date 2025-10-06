require 'forwardable'

class Kata::Offer
  extend Forwardable

  def_delegators :@discount, :discount
  def initialize(offer_type, product, argument)
    @discount = {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercent,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo
    }[offer_type].new({ argument:, product: })
  end
end
