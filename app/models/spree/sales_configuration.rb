module Spree
  class SalesConfiguration < Preferences::Configuration
    preference :sale_calculators, :array, default: []
  end
end
