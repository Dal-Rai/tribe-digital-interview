module FormatValidator

  def allowed_format
    BUNDLE_PRICE.keys
  end

  def invalid_formats(list)
    list.select { |item| allowed_format.exclude?(item) }
  end

  def valid_format?(list)
    invalid_formats(list).none?
  end

  def wrong_format_msg
    "Allowed format are #{allowed_format}"
  end
end