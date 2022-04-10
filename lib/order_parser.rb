class OrderParser
  attr_accessor(
    :items
  )

  def initialize(items)
    @items = items
  end

  def item_types
    items.split.select { |i| i[0] =~ /^[a-zA-Z]/ }
  end

  def split_order
    items.scan(/(\d+\ \w+)/).flatten
  end
end
