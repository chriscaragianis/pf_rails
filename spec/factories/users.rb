FactoryGirl.define do
  factory :user do
    name "MyString"
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "password"
  end
end
