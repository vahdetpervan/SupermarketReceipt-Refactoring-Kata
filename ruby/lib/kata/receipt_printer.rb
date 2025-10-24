class Kata::ReceiptPrinter
  def initialize(columns = 40, receipt)
    @columns = columns
    @result = ""
    @receipt = receipt
  end

  def print_receipt
    print_items
    print_discounts
    print_total_price
  end

  private

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size) = " " * whitespace_size

  def format_price(price) = "%.2f" % price

  def print_items
    @receipt.items.each do |item|
      @result.concat(
        item.product.name,
        whitespace(@columns - item.product.name.size - format_price(item.total_price).size),
        format_price(item.total_price) + "\n",
      )
      @result += "  " + format_price(item.price) + " * " + present_quantity(item) + "\n" if item.quantity != 1
    end
  end

  def print_discounts
    @receipt.discounts.each do |discount|
      @result.concat(
        discount.description, "(#{discount.product_name})",
        whitespace(@columns - 3 - discount.product_name.size - discount.description.size - format_price(discount.discount_amount).size),
        "-", format_price(discount.discount_amount) + "\n"
      )
    end
  end

  def print_total_price
    @result.concat("\n", "Total: ", whitespace(33 - format_price(@receipt.total_price).size), format_price(@receipt.total_price))
  end
end
