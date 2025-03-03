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
      discount = Kata::Discount.new(self.product, "2 for " + self.argument.to_s, discount_n)
    end
  end

end
