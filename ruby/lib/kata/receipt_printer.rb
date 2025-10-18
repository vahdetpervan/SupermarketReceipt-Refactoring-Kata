class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = print_items(receipt.items, "")
    print_discounts(receipt.discounts, result)
    print_total_price(result, receipt)
  end

  private

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size) = " " * whitespace_size

  def format_price(price) = "%.2f" % price

  def print_items(items, result)
    items.each do |item|
      name = item.product.name
      whitespace_size = @columns - name.size - format_price(item.total_price).size
      line = name + whitespace(whitespace_size) + format_price(item.total_price) + "\n"
      line += "  " + format_price(item.price) + " * " + present_quantity(item) + "\n" if item.quantity != 1

      result.concat(line)
    end
    result
  end

  def print_discounts(discounts, result)
    discounts.each do |discount|
      price_presentation = "%.2f" % discount.discount_amount
      result.concat(discount.description, "(#{discount.product_name})")
      result.concat(whitespace(@columns - 3 - discount.product_name.size - discount.description.size - price_presentation.size))
      result.concat("-", price_presentation + "\n")
    end
    result
  end

  def print_total_price(result, receipt)
    whitespace = whitespace(@columns - 7 - format_price(receipt.total_price).size)
    result.concat("\n", "Total: ", whitespace, format_price(receipt.total_price))
  end
end
