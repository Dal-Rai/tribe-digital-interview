class PostBundleCalculator
  attr_accessor(
    :posts,
    :post_bundle_price,
    :post_types,
  )

  def initialize(posts, post_types)
    @posts = posts
    @post_types = post_types
    @post_bundle_price = {}
  end

  def calc
    return unless valid_post?

    @post_types.each_with_object({}) do |item, memo|
      temp = []
      result = []
      bundles = post_bundles[item].sort
      post = posts.find{ |e| e.include?(item) }
      sum = post.to_i
      find_bundles(bundles, sum, 0, result, temp)
      memo[item] = format(item, post, result)
      @post_bundle_price.merge!(memo)
    end

    @post_bundle_price
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

  def post_bundles
    @post_types.each_with_object({}) do |post, memo|
      memo[post] = BUNDLE_PRICE[post].map { |x| x.keys }.flatten
    end
  end

  def format(item, post, result)
    ans = []

    bundle_prices = BUNDLE_PRICE[item][0]
    result.each do |items|
      sort_items = items.sort.reverse
      ans << format_item(sort_items, post, bundle_prices)
    end

    ans.sort_by{|x| x[:total]}.first
  end

  def format_item(items, post, bundle_prices)
    temp = []
    total = 0
    group_items = items.group_by(&:itself).transform_values(&:count)

    group_items.each do |key, value|
      price = bundle_prices[key] * value
      total += price
      temp << "#{value} X #{key} $#{price}"
    end

    format_order(post, total, temp)
  end

  def format_order(post, total, temp)
    {
      post: "#{post} $#{total}",
      total: total,
      sub_items: temp,
    }
  end

  def valid_post?
    FormatValidator.valid_format?(@post_types)
  end
end
