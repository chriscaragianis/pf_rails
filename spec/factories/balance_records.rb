FactoryGirl.define do
  sequence(:date) { |n| Date.today + n }
  factory :balance_record do
    balance 1.5
    date 
  end
end
