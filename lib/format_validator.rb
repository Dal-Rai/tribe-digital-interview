class FormatValidator
  class << self
    def allowed_format
      BUNDLE_PRICE.keys
    end

    def invalid_formats(item_types)
      item_types.select { |item| allowed_format.exclude?(item) }
    end

    def valid_format?(item_types)
      invalid_formats(item_types).none?
    end

    def allowed_format_msg
      "Allowed formats are #{allowed_format.to_sentence}"
    end
  end
end
