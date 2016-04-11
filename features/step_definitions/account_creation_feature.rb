Given(/^user not logged in$/) do
  visit root_path
  if page.body.include? "Log out" then
    click_link "Log out"
  end
end

Given(/^user visits (.*)$/) do |path|
  visit path
end


Then(/^flash error "([^"]*)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^sign_up form is displayed$/) do
  expect(page).to have_content("Sign up")
end

Given(/^new_account form has bad info$/) do
  fill_in "Acct name", :with => ""
end

And(/^done is (.*)checked$/) do |q|
  if q == "not " then
    uncheck "Done with accounts"
  else
    check "Done with accounts"
  end
end

Then(/^account is not created$/) do
  expect(Account.count).to eq(0)
end

Then(/^new_account form is displayed$/) do
  expect(page).to have_field("Acct name")
end

Given(/^new_account form has good info$/) do
  fill_in "Day", :with => "3"
  fill_in "Fixed amount", :with => "3"
  fill_in "Min rate", :with => "0.1"
  fill_in "Acct name", :with => "Account Feature"
  fill_in "Vest priority", :with => "1"
end


Then(/^account is created$/) do
  expect(Account.find_by(acct_name: "Account Feature")).to be_truthy
end

