class Kata::TenPercentDiscount
  def initialize(product:, argument:, quantity:, unit_price:)
    @product = product
    @argument = argument
    @quantity = quantity
    @unit_price = unit_price
  end

  def build
    Kata::Discount.new(@product, @argument.to_s + "% off", @quantity * @unit_price * @argument / 100.0)
  end
end