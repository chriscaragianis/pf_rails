When /^a user visits the site$/ do
  visit '/'
end

Then(/^display the new button$/) do
  expect(page).to have_button("new")
end

When(/^a user clicks the new button$/) do
  click_button('new')
end

Then(/^display an account form$/) do
  expect(page).to have_field('account_name')
end

Given(/^an account form is filled out$/) do
  fill_in 'account_name', with: "test"
end

Given(/^a user clicks add$/) do
  click_button('add_account')
end

Then(/^display a blank account form$/) do
  expect(page).to have_field('account_name')
end
