Spree::BaseHelper.class_eval do
  def display_original_price(product_or_variant)
    current_currency ||= Spree::Config[:currency]
    product_or_variant.original_price_in(current_currency).display_price.to_html
  end

  def display_discount_percent(product_or_variant, append_text="Off")
    discount = product_or_variant.discount_percent_in current_currency

    # number_to_percentage(discount, precision: 0).to_html

    if discount > 0
      return "#{number_to_percentage(discount, precision: 0).to_html} #{append_text}"
    else
      return ""
    end
  end

  # Check if a sale is the current sale for a product, returns true or false
  def active_for_sale_price product, sale_price
    product.current_sale_in(Spree::Config[:currency]) == sale_price
  end

  def spree_sale_currencies
    currencies = ::Money::Currency.table.map do |_code, details|
      iso = details[:iso_code]
      [iso, "#{details[:name]} (#{iso})"]
    end

    currencies << [:all_currencies, Spree.t(:all_currencies)]

    options_from_collection_for_select(currencies, :first, :last, Spree::Config[:currency])
  end

  def sale_calculators
    calculators = Spree::SalesConfiguration::Config.calculators.map do |calculator|
      [calculator.title, calculator.name]
    end

    options_for_select(calculators)
  end
end
