class Kata::Offer

  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def discount(quantity:, unit_price:)
    return Kata::Discounts::TwoForAmount.new(argument:, quantity:, unit_price:, product:).calculate if offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
    return Kata::Discounts::ThreeForTwo.new(quantity:, unit_price:, product:).calculate if offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
    return Kata::Discount.new(product, argument.to_s + "% off", quantity * unit_price * argument / 100.0) if offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT

    calculate_five_for_amount_discount(quantity:, unit_price:) if offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
  end

  private

  def calculate_five_for_amount_discount(quantity:, unit_price:)
    item_units_for_discount = quantity.to_i / 5
    discount_total = unit_price * quantity - (argument * item_units_for_discount + quantity.to_i % 5 * unit_price)
    Kata::Discount.new(product, 5.to_s + " for " + argument.to_s, discount_total)
  end
end
