FactoryGirl.define do
  factory :account do
    acct_name "MyString"
    rate 1.5
    min_rate 1.5
    balance 1.5
    day 1
    weekly false
    carry_balance false
    week_period 1
    week_offset 1
    vest_priority 1
  end
end
