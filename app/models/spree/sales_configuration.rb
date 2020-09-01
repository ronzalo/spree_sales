module Spree
  class SalesConfiguration < Preferences::Configuration
    preference :sale_calculators, :array, default: []
    preference :first_price_order, :string, default: 'created_at DESC'
    preference :only_active_variants, :boolean, default: false
  end
end
