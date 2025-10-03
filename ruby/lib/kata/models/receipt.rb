class Kata::Receipt
  attr_reader :items, :discounts

  def initialize
    @items = []
    @discounts = []
  end

  def total_price
    total = 0
    total += @items.sum(&:total_price)
    # @items.each { |item| total += item.total_price }
    @discounts.each { |discount| total -= discount.discount_amount }
    total
  end

  def add_product(product, quantity, price, total_price)
    @items << Kata::ReceiptItem.new(product, quantity, price, total_price)
  end

  def add_discount(discount) = @discounts << discount
end
