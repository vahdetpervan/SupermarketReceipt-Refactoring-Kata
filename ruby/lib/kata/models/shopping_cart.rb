require 'ostruct'

class Kata::ShoppingCart
  attr_reader :items, :product_quantities

  def initialize
    @items = []
    @product_quantities = Hash.new(0)
    @discount_classes = {
      Kata::SpecialOfferType::TWO_FOR_AMOUNT => Kata::Discounts::TwoForAmount,
      Kata::SpecialOfferType::THREE_FOR_TWO => Kata::Discounts::ThreeForTwo,
      Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT => Kata::Discounts::TenPercentDiscount,
      Kata::SpecialOfferType::FIVE_FOR_AMOUNT => Kata::Discounts::FiveForAmount
    }.freeze
  end

  def add_item_quantity(product, quantity)
    @items << ::OpenStruct.new(product:, quantity:)
    product_quantities[product] += quantity
  end

  def handle_offers(receipt, offers, catalog)
    @product_quantities.each do |product, quantity|
      next unless offers.key?(product)

      discount = @discount_classes[offers[product].offer_type].new({offers:, product:, unit_price: catalog.unit_price(product), quantity:, argument: offers[product].argument}).calculate

      receipt.add_discount(discount) if discount
    end
  end
end
