module Spree
  module Admin
    class SalePricesController < BaseController
      before_filter :load_product
      before_filter :load_sale_prices

      respond_to :js, :html

      # Show all sale prices for a product
      def index
        @sale_price = Spree::SalePrice.new
      end

      # Create a new sale price
      def create
        @sale_price = Spree::SalePrice.new sale_price_params

        if @sale_price.save
          # @product.put_on_sale sale_price_params[:value], sale_price_params
          redirect_to admin_product_sale_prices_path(@product)
        else
          render :index
        end
      end

      # Destroy a sale price
      def destroy
        sale_price = Spree::SalePrice.find(params[:id])
        sale_price.destroy

        respond_with(sale_price)
      end


      private
        # Load the product as a before filter. Redirect to the referer if no product is found
        def load_product
          @product = Spree::Product.find_by(slug: params[:product_id])
          redirect_to request.referer unless @product.present?
        end

        # Load product sale_prices as a before filter.
        def load_sale_prices
          @sale_prices = @product.sale_prices
        end

        # Sale price params
        def sale_price_params
          params.require(:sale_price).permit(
            # :id,
            :value,
            :start_at,
            :end_at,
            # :enabled,
            # :all_variants,
            # :all_currencies,
            :calculator
          )
        end
    end
  end
end
