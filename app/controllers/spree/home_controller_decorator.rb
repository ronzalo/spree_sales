module Spree
  HomeController.class_eval do
    def sale
      # TODO Refactor to include sales in searcher builder
      if params[:id]
        @taxon = Spree::Taxon.find_by_permalink!(params[:id])
        @products = Spree::Product.in_sale.in_taxon(@taxon)
      else
        @products = Spree::Product.in_sale
      end
    end
  end
end