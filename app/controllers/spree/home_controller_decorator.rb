module Spree
  HomeController.class_eval do
    def sale
      # TODO Refactor to include sales in searcher builder
      @products = Product.joins(:master => :sale_prices).uniq
    end
  end
end