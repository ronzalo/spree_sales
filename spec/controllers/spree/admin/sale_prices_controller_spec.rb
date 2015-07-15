require 'spec_helper'

describe Spree::Admin::SalePricesController, type: :controller do
  routes { Spree::Core::Engine.routes }
  let(:product) { mock_model(Spree::Product, touch: nil, sale_prices: [], variants_including_master: []) }
  let(:sale_price) { mock_model(Spree::SalePrice) }
  let(:user) { mock_model(Spree::User) }

  before do
    controller.stub(:spree_current_user).and_return(user)
    controller.stub(:authorize_admin).and_return(true)
    allow(Spree::Product).to receive(:find_by).and_return(product)
  end

  describe 'destroy format: js' do
    before do
      allow(Spree::SalePrice).to receive(:find).and_return(sale_price)
    end

    it 'finds the sale price by param' do
      expect(Spree::SalePrice).to receive(:find).with('1337').and_return(sale_price)
      delete :destroy, id: 1337, product_id: 42, format: :js
    end

    it 'deletes the sale price' do
      expect(sale_price).to receive(:destroy)
      delete :destroy, id: 1337, product_id: 42, format: :js
    end

    it 'touches the product, effectively renewing the cache' do
      expect(product).to receive(:touch)
      delete :destroy, id: 1337, product_id: 42, format: :js
    end
  end
end
