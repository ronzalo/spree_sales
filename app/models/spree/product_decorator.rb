module Spree::ProductDecorator
  def self.prepended(base)
    base.include Spree::ProductOnSalable
  end
end

Spree::Product.prepend(Spree::ProductDecorator)
