class PostBundleCalculator
  attr_accessor(
    :items,
    :item_types,
    :item_bundle_prices,
  )

  def initialize(items, item_types)
    @items = items
    @item_types = item_types
    @item_bundle_prices = {}
  end

  def perform
    return unless valid_order?

    item_types.each_with_object({}) do |type, memo|
      temp = []
      result = []
      bundles = item_bundles[type].sort
      item = items.find{ |e| e.include?(type) }
      sum = item.to_i
      find_bundles(bundles, sum, 0, result, temp)

      memo[type] = result.empty? ? fallback_price(type, item, sum) : format_item(type, item, result)
      item_bundle_prices.merge!(memo)
    end

    item_bundle_prices
  end

  def find_bundles(bundles, sum, i, result, temp)
    if (sum == 0)
      result << temp.dup
    else
      (i...bundles.count).map do |i|
        if ((sum - bundles[i]) >= 0)
          temp << bundles[i]
          find_bundles(bundles, sum - bundles[i], i, result, temp)
          temp.delete_at(temp.index(bundles[i]))
        end
      end
    end
  end

  def fallback_price(type, item, sum)
    number, amount = BUNDLE_PRICE[type][0].first
    total = sum * amount / number
    {
      item: "#{item} $#{total}",
      total: total,
      sub_items: [],
    }
  end

  def item_bundles
    item_types.each_with_object({}) do |type, memo|
      memo[type] = BUNDLE_PRICE[type].map { |x| x.keys }.flatten
    end
  end

  def format_item(type, item, result)
    ans = []

    bundle_prices = BUNDLE_PRICE[type][0]
    result.each do |bundles|
      sort_bundles = bundles.sort.reverse
      ans << format_sub_item(sort_bundles, item, bundle_prices)
    end

    ans.sort_by{ |x| x[:total] }.first
  end

  def format_sub_item(bundles, item, bundle_prices)
    temp = []
    total = 0
    group_bundles = bundles.group_by(&:itself).transform_values(&:count)

    group_bundles.each do |key, value|
      price = bundle_prices[key] * value
      total += price
      temp << "#{value} X #{key} $#{price}"
    end

    hash_sub_item(item, total, temp)
  end

  def hash_sub_item(item, total, temp)
    {
      item: "#{item} $#{total}",
      total: total,
      sub_items: temp,
    }
  end

  def valid_order?
    FormatValidator.valid_format?(item_types)
  end
end
