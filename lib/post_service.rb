class PostService
  attr_accessor(
    :parser,
    :posts,
    :post_types,
    :post_bundle,
    :bundler
  )

  def initialize(posts)
    @posts = posts
    @post_types = order_parser.post_types
    @post_bundle = order_parser.split_post
  end

  def print_result
    if bundler.valid_post?
      bundler.calc.each do |key, value|
        puts sprintf(value[:post])
        value[:sub_items].each do |item|
          puts sprintf("       " + item)
        end
      end
    else
      puts FormatValidator.allowed_format_msg
    end
  end

  def bundler
    @bundler ||= PostBundleCalculator.new(@post_bundle, @post_types)
  end

  def order_parser
    @parser ||= PostParser.new(@posts)
  end
end