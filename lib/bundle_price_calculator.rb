class BundlePriceCalculator
  attr_accessor(
    :parser
  )

  def initialize

  end

  def parse_order
    @parser ||= OrderParser
  end
end