def media_bundles
  item_types.each_with_object({}) do |type, memo|
    memo[type] = BUNDLE_PRICE[type].map { |x| x.keys }.flatten
  end
end
