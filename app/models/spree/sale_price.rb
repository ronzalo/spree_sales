module Spree
  class SalePrice < ActiveRecord::Base
    attr_accessor :currency, :variant

    # TODO: validations
    belongs_to :default_price, class_name: "Spree::Price", foreign_key: "price_id"
    belongs_to :price, class_name: "Spree::Price"
    has_one :calculator, class_name: "Spree::Calculator", as: :calculable, dependent: :destroy

    accepts_nested_attributes_for :calculator

    validates :calculator, presence: true
    validates :value, numericality: { greater_than: 0 }

    validates_presence_of :start_at
    validates :end_at, date: { after: :start_at, allow_blank: true }

    delegate :currency, to: :default_price

    scope :active, -> { where(enabled: true).where("(start_at <= ? OR start_at IS NULL) AND (end_at >= ? OR end_at IS NULL)", Time.now, Time.now) }

    def initialize attrs={}
      attrs[:calculator] = attrs[:calculator].constantize.new if attrs && attrs[:calculator].present?

      super attrs
    end

    def calculator_type
      calculator.class.to_s if calculator
    end

    def new_amount
      calculator.compute self
    end

    def enable
      update_attribute(:enabled, true)
    end

    def disable
      update_attribute(:enabled, false)
    end

    def start(end_time=nil)
      end_time = nil if end_time.present? && end_time <= Time.now # if end_time is not in the future then make it nil (no end)
      attr = {end_at: end_time, enabled: true}
      attr[:start_at] = Time.now if start_at.present? && start_at > Time.now # only set start_at if it's not set in the past
      update_attributes(attr)
    end

    def stop
      update_attributes(end_at: Time.now, enabled: false)
    end

    # Convenience method for displaying the price of a given sale_price in the table
    def display_price
      Spree::Money.new(new_amount, currency: currency)
    end

    # Custom method: For adding sale price validation #
    def validate_value value, params
      unless params['variant'] == 'all_variants'
        variant = Spree::Variant.where(id: params['variant']).first
        return false unless variant
      end

      valid_sale = true
      if params['calculator'] == 'Spree::Calculator::AmountSalePriceCalculator'
        if variant && value.to_f > variant.original_price.to_f
          errors.add(:value, 'value should not be greater than the original price')
          valid_sale = false
        end
      else
        unless value.to_f.between?(0.0, 1.0)
          errors.add(:value, "percent should between 0.0 and 1.0 (#{calculator.class.title})")
          valid_sale = false
        end
      end
      return valid_sale
    end
  end
end
