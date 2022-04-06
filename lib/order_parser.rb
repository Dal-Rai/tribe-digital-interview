class Lib::OrderParser
  attr_accessor(
    :items,
  )

  def initialize(items)
    @items = items
  end

  def parse
    items.split.grep(String).join(' ')
  end
end