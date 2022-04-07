class PostService
  attr_accessor(
    :parser,
    :posts
  )

  def initialize(posts)
    @posts = posts
  end

  def calculate
    if FormatValidator.valid_format?(order_parser.post_types)
      order_parser.split_post
    else
      puts FormatValidator.allowed_format_msg
    end
  end

  def order_parser
    @parser ||= PostParser.new(@posts)
  end
end