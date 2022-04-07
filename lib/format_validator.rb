class FormatValidator
  class << self
    def allowed_format
      BUNDLE_PRICE.keys
    end

    def invalid_formats(post_type)
      post_type.select { |item| allowed_format.exclude?(item) }
    end

    def valid_format?(post_type)
      invalid_formats(post_type).none?
    end

    def allowed_format_msg
      "Allowed format are #{allowed_format}"
    end
  end
end
