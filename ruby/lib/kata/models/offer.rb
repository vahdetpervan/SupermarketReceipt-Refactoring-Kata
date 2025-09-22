class Kata::Offer

  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def discount(quantity:, unit_price:)
    return Kata::TwoForAmount.new(argument: argument, quantity: quantity, unit_price: unit_price, product: product).build if offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
    return Kata::ThreeForTwo.new(quantity: quantity, unit_price: unit_price, product: product).build if offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
    return Kata::TenPercentDiscount.new(product: product, argument: argument, quantity: quantity, unit_price: unit_price).build if offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT

    if offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
      item_units_for_discount = quantity.to_i / 5
      discount_total = unit_price * quantity - (argument * item_units_for_discount + quantity.to_i % 5 * unit_price)
      Kata::Discount.new(product, 5.to_s + " for " + argument.to_s, discount_total)
    end
  end

end
