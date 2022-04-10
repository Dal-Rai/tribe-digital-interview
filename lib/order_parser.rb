class OrderParser

  attr_accessor(
    :order,
  )

  def initialize(order)
    @order = order
  end

  def item_types
    order.split.select { |i| i[0] =~ /^[a-zA-Z]/ }
  end

  def split_order
    order.scan(/(\d+\ \w+)/).flatten
  end
end
