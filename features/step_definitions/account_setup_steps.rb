When /^a user visits the site$/ do
  visit '/'
end

Then(/^display the Start link$/) do
  expect(page).to have_content("Start")
end

When(/^a user clicks (.*)$/) do |link|
  click_link(link)
end

When(/^a user button clicks (.*)$/) do |link|
  click_button(link)
end

When(/^a user submits (.*)$/) do |button|
  click_button(button)
end

Then(/^display an account form$/) do
  expect(page).to have_field('account[acct_name]')
  expect(page).to have_field('account[balance]')
  expect(page).to have_field('account[rate]')
  expect(page).to have_field('account[day]')
  expect(page).to have_unchecked_field('account[weekly]')
end

Then(/^the db is cleared$/) do
  expect(Account.count).to eq(0)
end

Given(/^the form is filled out$/) do
  visit '/accounts/new'
  fill_in 'account[acct_name]', with: "test"
end

Then(/^display a blank account form$/) do
  expect(page).to have_field('account_name')
end

Then(/^an Account is saved$/) do
  expect(Account.count).to eq(1)
end

Then(/^add another is displayed$/) do
  expect(page).to have_content('Add Another')
end

Then(/^finish is displayed$/) do
  expect(page).to have_content('Done with accounts')
end

Then(/^list accounts$/) do
  expect(page).to have_content('Name: test')
end

Then(/^Create Scenario is displayed$/) do
  expect(page).to have_content("Define Scenario")
end
