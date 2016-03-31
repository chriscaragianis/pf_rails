Given(/^user logged in$/) do
  User.create(email: "me@gmail.com", password: "password", name: "MyName")
  visit '/sessions/new'
  fill_in "Email", :with => "me@gmail.com"
  fill_in "Password", :with => "password"
  click_button("Log in")
end


When(/^user submits (.*)$/) do |button_label|
  click_button(button_label)
end

Then(/^flash success$/) do
  expect(page).to have_content("Success!")
end

Then(/^dashboard is displayed$/) do
  expect(page).to have_content("Your Accounts")
end

Then(/^sign_up page is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^accounts are displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^scenarios are displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^new_account link is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^new_scenario link is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^run_scenario link is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^logged in user$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^no logged in user$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^log_in form is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^log_in form has good info$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^flash success "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^session is created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^log_in form has bad info$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^session is not created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^sign_up form has good info$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^user is created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^info_page is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^sign_up form has bad info$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^user is not created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^display login link$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^display sign_up link$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^don't display new_account link$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^don't display new_scenario link$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^render dashboard$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
