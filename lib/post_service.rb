class PostService
  attr_accessor(
    :order,
    :items,
    :calculator,
    :item_types,
    :order_parser,
  )

  def initialize(order)
    @order = order
    @item_types = order_parser.item_types
    @items = order_parser.split_order
  end

  def print_result
    if calculator.valid_order?
      calculator.perform.each do |_key, value|
        puts(value[:item])
        value[:sub_items].each do |item|
          puts("       " + item)
        end
      end
    else
      puts FormatValidator.allowed_format_msg
    end
  end

  def calculator
    @calculator ||= PostBundleCalculator.new(items, item_types)
  end

  def order_parser
    @order_parser ||= OrderParser.new(order)
  end
end
