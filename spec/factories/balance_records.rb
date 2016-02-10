FactoryGirl.define do
  factory :balance_record do |b|
    b.balance 1.5
    b.date "2016-02-09"

    factory :balance_record_with_accounts do
      b.accounts { |accts| [accts.association(:account)] } 
    end
  end
end
