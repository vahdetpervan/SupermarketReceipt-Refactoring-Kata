class Kata::Offer

  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def handle(quantity:, unit_price:)
    if self.offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
      total = self.argument * (quantity.to_i / 2) + quantity.to_i % 2 * unit_price
      discount_n = unit_price * quantity - total
      return Kata::Discount.new(self.product, "2 for " + self.argument.to_s, discount_n)
    end
    if self.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity.to_i >= 5
      item_units_for_discount = quantity.to_i / 5
      discount_total = unit_price * quantity - (argument * item_units_for_discount + quantity.to_i % 5 * unit_price)
      return Kata::Discount.new(product, 5.to_s + " for " + argument.to_s, discount_total)
    end
  end

end
