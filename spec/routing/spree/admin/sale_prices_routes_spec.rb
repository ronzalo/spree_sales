require "spec_helper"

RSpec.describe Spree::Admin::SalePricesController, type: :routing do
  describe "routing" do
    routes { Spree::Core::Engine.routes }

    it "routes to #index" do
      expect(get: admin_product_sale_prices_path(1)).to route_to(controller: "spree/admin/sale_prices", action: "index", product_id: "1")
    end

    it "routes to #create" do
      expect(post: admin_product_sale_prices_path(1)).to route_to(controller: "spree/admin/sale_prices", action: "create", product_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: admin_product_sale_price_path(1, 1)).to route_to(controller: "spree/admin/sale_prices", action: "destroy", product_id: "1", id: "1")
    end
  end
end
