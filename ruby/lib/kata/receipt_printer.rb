class Kata::ReceiptPrinter

  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = ""
    receipt.items.each do |item|
      price = "%.2f" % item.total_price
      quantity = present_quantity(item)
      name = item.product.name
      unit_price = "%.2f" % item.price

      whitespace_size = @columns - name.size - price.size
      line = name + whitespace(whitespace_size) + price + "\n"

      if item.quantity != 1
        line += "  " + unit_price + " * " + quantity + "\n"
      end

      result.concat(line);
    end
    receipt.discounts.each do |discount|
      product_presentation = discount.product.name
      price_presentation = "%.2f" % discount.discount_amount
      description = discount.description
      result.concat(description)
      result.concat("(")
      result.concat(product_presentation)
      result.concat(")")
      result.concat(whitespace(@columns - 3 - product_presentation.size - description.size - price_presentation.size))
      result.concat("-");
      result.concat(price_presentation);
      result.concat("\n");
    end
    result.concat("\n")
    price_presentation = "%.2f" % receipt.total_price.to_f
    total = "Total: "
    whitespace = whitespace(@columns - total.size - price_presentation.size)
    result.concat(total, whitespace, price_presentation)
    result
  end

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size)
    ' ' * whitespace_size
  end
end
