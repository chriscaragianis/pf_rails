Given(/^Account is empty$/) do
  Account.delete_all
end

When(/^a user visits accounts\/new$/) do
  visit "accounts/new"
end

Then(/^account_list is displayed$/) do
  find_by_id("account_list")
end

Then(/^account_list is empty$/) do
  expect(page).not_to have_selector('li')
end

When(/^the account form is filled out$/) do
  fill_in(:account_acct_name, with: 'NAME')
  fill_in(:account_balance, with: 1.5)
  fill_in(:account_rate, with: 1)
  fill_in(:account_min_rate, with: 1)
  fill_in(:account_day, with: 1)
  fill_in(:account_fixed_amount, with: 1)
  fill_in(:account_vest_priority, with: 1)
end

When(/^a user submits Save Account$/) do
  click_button('Save Account')
end

Then(/^(\d+) account_box is displayed$/) do |arg1|
  expect(page).to have_selector('.acct_box', count: arg1)
end

Given(/^(\d+) Account exists$/) do |arg1|
  Account.delete_all
  arg1.to_i.times { FactoryGirl.create(:account) }
end

