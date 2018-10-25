FactoryBot.define do
  factory :sale_price, class: Spree::SalePrice do
    price
    calculator
    value { 10 }
    start_at { 1.week.ago }
    end_at   { 1.week.from_now }
  end
end