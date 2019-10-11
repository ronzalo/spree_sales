module Spree::HomeControllerDecorator
  # TODO: Refactor to include sales in searcher builder
  def sale
    if params[:id]
      @taxon = Spree::Taxon.find_by!(slug: params[:id])
      @products = Spree::Product.in_sale.in_taxon(@taxon)
    else
      @products = Spree::Product.in_sale
    end
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end
end

Spree::HomeController.prepend(Spree::HomeControllerDecorator)
