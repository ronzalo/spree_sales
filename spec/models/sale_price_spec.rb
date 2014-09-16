require 'spec_helper'

describe Spree::SalePrice do
  let!(:product) { create(:product, price: 50) }
  let!(:variant) { create(:variant, price: 50) }
  let(:sale_price) { create(:sale_price) }

  context "product#put_on_sale" do
    before {
      product.put_on_sale(10, {start_at: 7.days.ago, end_at: 7.days.from_now})
    }

    it "should be active sale_price" do
      expect(product.price.to_i).to be 10
    end

    it "product should be on sale" do
      expect(product.on_sale?).to be true
    end

    it "product on sale should have an original price" do
      expect(product.original_price.to_i).to be 50
    end

    it "product active sale should be an sale price class" do
      expect(product.active_sale_in(Spree::Config[:currency]).class).to be Spree::SalePrice
    end
  end

  context "variant#put_on_sale" do
    before {
      variant.put_on_sale(10, {start_at: 7.days.ago, end_at: 7.days.from_now})
    }

    it "variant should be on sale" do
      expect(variant.on_sale?).to be true
    end

    it "variant product should be out of sale" do
      expect(variant.product.on_sale?).to be false
    end

  end

  context "validations" do

    it "should validate price over 0" do
      sale_price.value = 0
      sale_price.should be_invalid
    end

    it "should validate end_at is greater than start_at" do
      sale_price.end_at = sale_price.start_at - 1.day
      sale_price.should be_invalid
    end
  end
end
