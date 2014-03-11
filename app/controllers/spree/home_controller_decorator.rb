module Spree
  HomeController.class_eval do
    def sale
      # TODO Refactor to include sales in searcher builder
      if params[:id]
        @taxon = Spree::Taxon.by_store(current_store).find_by_permalink!(params[:id])
        @products = Spree::Product.by_store(current_store.id).in_sale.in_taxon(@taxon)
      else
        @products = Spree::Product.by_store(current_store.id).in_sale
      end
    end
  end
end