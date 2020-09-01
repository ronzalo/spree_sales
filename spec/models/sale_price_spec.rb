require "spec_helper"

describe Spree::SalePrice do
  let!(:product) { create(:product, price: 50) }
  let!(:variant) { create(:variant, price: 50) }
  
  let!(:product2) { create(:product, price: 100) }
  let!(:variant21) { create(:variant, product: product2, price: 100) }
  let!(:variant22) { create(:variant, product: product2, price: 100, discontinue_on: 1.day.ago) }
  let(:sale_price) { create(:sale_price) }

  context "product#put_on_sale" do
    context "when put on sale with percent calculator" do
      before {
        product.put_on_sale(0.1, start_at: 7.days.ago, end_at: 7.days.from_now, calculator: "Spree::Calculator::PercentOffSalePriceCalculator")
      }

      it "should be active sale_price" do
        expect(product.price.to_i).to be 45
      end
    end

    context "when put on sale" do
      before {
        product.put_on_sale(10, start_at: 7.days.ago, end_at: 7.days.from_now)
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

    it "touches the product, effectively updating the cache" do
      expect(product).to receive(:touch)
      product.put_on_sale(10, start_at: 7.days.ago, end_at: 7.days.from_now)
    end
  end

  context "variant#put_on_sale" do
    context "when put on sale" do
      before {
        variant.put_on_sale(10, start_at: 7.days.ago, end_at: 7.days.from_now)
      }

      it "variant should be on sale" do
        expect(variant.on_sale?).to be true
      end

      it "variant product should be out of sale" do
        expect(variant.product.on_sale?).to be false
      end
    end
  end

  context "validations" do
    it "should validate price over 0" do
      sale_price.value = 0
      expect(sale_price).to be_invalid
    end

    it "should validate end_at is greater than start_at" do
      sale_price.end_at = sale_price.start_at - 1.day
      expect(sale_price).to be_invalid
    end
  end

  context "only active variants" do
    it "should put on sale only active variants" do
      SpreeSales::Config.only_active_variants = true
      product2.put_on_sale(90, start_at: 7.days.ago, end_at: 7.days.from_now)

      expect(variant21.price.to_i).to eq 90
      expect(variant22.price.to_i).to eq 100
    end
  end

  context "first active sale" do
    before { product2.disable_sale }

    it "should pick the first active sale using first_price_order preference" do
      SpreeSales::Config.first_price_order = "value asc"

      product2.put_on_sale(50, start_at: 7.days.ago, end_at: 7.days.from_now)
      expect(variant21.price.to_i).to eq 50

      product2.put_on_sale(70, start_at: 7.days.ago, end_at: 7.days.from_now)
      expect(variant21.price.to_i).to eq 50
    end
  end
end
