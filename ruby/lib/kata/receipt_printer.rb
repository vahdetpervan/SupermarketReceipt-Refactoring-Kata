class Kata::ReceiptPrinter

  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = print_items(receipt)
    print_discounts(receipt, result)
    print_pricing(receipt, result)
  end

  private

  def print_items(receipt)
    receipt.items.each_with_object("") do |item, result|
      price = "%.2f" % item.total_price
      name = item.product.name
      unit_price = "%.2f" % item.price

      whitespace_size = @columns - name.size - price.size
      line = name + whitespace(whitespace_size) + price + "\n"

      line += "  " + unit_price + " * " + present_quantity(item) + "\n" if item.quantity != 1

      result.concat(line)
    end
  end

  def print_discounts(receipt, result)
    receipt.discounts.each do |discount|
      price_presentation = "%.2f" % discount.discount_amount
      result.concat(discount.description)
      result.concat("(#{discount.product.name})")
      result.concat(whitespace(@columns - 3 - discount.product.name.size - discount.description.size - price_presentation.size))
      result.concat("-", price_presentation, "\n")
    end
  end

  def print_pricing(receipt, result)
    insert_blank_line(result)
    price_presentation = "%.2f" % receipt.total_price.to_f
    total = "Total: #{whitespace(@columns - 7 - price_presentation.size)}"
    result.concat(total, price_presentation)
  end

  def insert_blank_line(result)
    result.concat("\n")
  end

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size) = ' ' * whitespace_size
end
