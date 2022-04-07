class PostParser

  attr_accessor(
    :items,
  )

  def initialize(items)
    @items = items
  end

  def post_types
    items.split.select { |i| i[0] =~ /^[a-zA-Z]/ }
  end

  def split_post
    items.scan(/(\d+\ \w+)/).flatten
  end
end
