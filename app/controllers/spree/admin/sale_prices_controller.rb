module Spree
  module Admin
    class SalePricesController < BaseController

      before_filter :load_product

      respond_to :js, :html

      # Show all sale prices for a product
      def index
        @sale_prices = @product.sale_prices
      end

      # Create a new sale price
      def create
        @sale_price = @product.put_on_sale params[:sale_price][:value], sale_price_params
        respond_with(@sale_price)
      end

      # Destroy a sale price
      def destroy
        @sale_price = Spree::SalePrice.find(params[:id])
        @sale_price.destroy

        respond_with(@sale_price)
      end


      private

        # Load the product as a before filter. Redirect to the referer if no product is found
        def load_product
          @product = Spree::Product.find_by_permalink(params[:product_id])
          redirect_to request.referer unless @product.present?
        end

        # Sale price params
        def sale_price_params
          params.require(:sale_price).permit(
            :id,
            :value,
            :start_at,
            :end_at,
            :enabled
          )
        end

    end
  end
end