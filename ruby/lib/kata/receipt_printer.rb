class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
    @result = ""
  end

  def print_receipt(receipt)
    result = print_items(receipt.items)
    print_discounts(receipt.discounts)
    print_total_price(result, receipt)
  end

  private

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size) = " " * whitespace_size

  def format_price(price) = "%.2f" % price

  def print_items(items)
    items.each do |item|
      whitespace_size = @columns - item.product.name.size - format_price(item.total_price).size
      line = item.product.name + whitespace(whitespace_size) + format_price(item.total_price) + "\n"
      line += "  " + format_price(item.price) + " * " + present_quantity(item) + "\n" if item.quantity != 1
      @result.concat(line)
    end
    @result
  end

  def print_discounts(discounts)
    discounts.each do |discount|
      @result.concat(
        discount.description, "(#{discount.product_name})",
        whitespace(@columns - 3 - discount.product_name.size - discount.description.size - format_price(discount.discount_amount).size),
        "-", format_price(discount.discount_amount) + "\n"
      )
    end
    @result
  end

  def print_total_price(result, receipt)
    @result.concat("\n", "Total: ", whitespace(33 - format_price(receipt.total_price).size), format_price(receipt.total_price))
  end
end
