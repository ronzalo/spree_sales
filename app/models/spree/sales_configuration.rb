module Spree
  class SalesConfiguration < Preferences::Configuration
    attr_accessor :calculators

    def initialize
      @calculators = []
    end
  end
end
