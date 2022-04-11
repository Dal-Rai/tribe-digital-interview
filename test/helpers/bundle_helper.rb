def item_bundles
  item_types.each_with_object({}) do |type, memo|
    memo[type] = BUNDLE_PRICE[type].map(&:keys).flatten
  end
end

def item_types
  BUNDLE_PRICE.keys
end

def first_item_type
  item_types.first
end

def first_item_bundle_price
  BUNDLE_PRICE[first_item_type][0].first
end

def valid_order
  order = ''
  item_types.each { |type| order += "#{item_bundles[type].sum} #{type} " }
  order.strip
end

def invalid_type_order
  order = ''
  item_types.each { |type| order += "#{item_bundles[type].sum} #{type.pluralize} " }
  order.strip
end

def no_combination_sum
  order = ''
  item_types.each { |type| order += "#{item_bundles[type].sum + 1} #{type} " }
  order.strip
end
