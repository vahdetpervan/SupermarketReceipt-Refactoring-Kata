class Kata::ReceiptItem
  attr_reader :product, :quantity, :price, :total_price

  def initialize(product, quantity, price, total_price)
    @product = product
    @quantity = quantity
    @price = price
    @total_price = total_price
  end
end
