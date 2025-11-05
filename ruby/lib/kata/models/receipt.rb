class Kata::Receipt
  attr_reader :items, :discounts, :bundles

  def initialize
    @items, @discounts, @bundles = [], [], []
  end

  def total_price = @items.sum(&:total_price) - @discounts.sum(&:discount_amount) - @bundles.sum(&:discount_amount).round(2)

  def add_product(product, quantity, price, total_price) = @items << Kata::ReceiptItem.new(product, quantity, price, total_price)

  def add_discount(discount) = @discounts << discount

  def add_bundle(bundle) = @bundles << bundle
end
