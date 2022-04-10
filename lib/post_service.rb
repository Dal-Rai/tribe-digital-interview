class PostService
  attr_accessor(
    :order,
    :items,
    :calculator,
    :item_types,
    :order_parser,
    :item_prices
  )

  def initialize(order)
    @order = order
    @item_types = order_parser.item_types
    @items = order_parser.split_order
  end

  def item_prices
    @item_prices ||=  calculator.perform
  end

  def print_result
    if item_prices.empty?
      puts format(FormatValidator.allowed_format_msg)
    else
      item_prices.each_value do |value|
        puts("#{value[:item]} $#{round(value[:total])}")

        value[:sub_items].each do |item|
          puts format('%<space>-7s%<count>i%<x_sign>-1s%<bundle>i%<dollar>s%<total>s', space: '', count: item[:count], x_sign: ' x ', bundle: item[:bundle], dollar: ' $', total: round(item[:total]))
        end
      end
    end
  end

  private

  def calculator
    @calculator ||= PostBundleCalculator.new(items, item_types)
  end

  def order_parser
    @order_parser ||= OrderParser.new(@order)
  end

  def round(value)
    value.is_a?(Integer) ? value : '%.2f'% value
  end
end
