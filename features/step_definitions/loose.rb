Given(/^user logged in$/) do
  @user = User.create(email: "me@gmail.com", password: "password", name: "MyName")
  visit '/sessions/new'
  fill_in "Email", :with => "me@gmail.com"
  fill_in "Password", :with => "password"
  click_button("Log in")
end

And(/^user has an account$/) do
  acct = Account.new(min_rate: 0,
                     vest_priority: 1,
                     day: 5,
                     acct_name: "Account Name",
                     fixed_amount: 3,
                     user_id: @user.id)
  acct.save
end

And(/^user has a scenario$/) do
  scene = Scenario.new(name: "Scene Name", vest_level: 1, user_id: @user.id)
  if !scene.save then
    puts "EMERGENCYEEEEE"
  end
end

When(/^user submits (.*)$/) do |button_label|
  click_button(button_label)
end

Then(/^flash success$/) do
  expect(page).to have_content("Success!")
end

Then(/^flash success "Welcome!"$/) do
  expect(page).to have_content("Welcome!")
end

Then(/^flash success "Logged in"$/) do
  expect(page).to have_content("Logged in")
end

Then(/^dashboard is displayed$/) do
  expect(page).to have_content("Your Accounts")
end

Then(/^accounts are displayed$/) do
  expect(page).to have_content("Account Name")
end

Then(/^scenarios are displayed$/) do
  expect(page).to have_content("Scene Name")
end

Then(/^new_account link is displayed$/) do
  expect(page).to have_link("New Account")
end

Then(/^new_scenario link is displayed$/) do
  expect(page).to have_link("Setup Scenario")
end

Then(/^run_scenario link is displayed$/) do
  expect(page).to have_link("Run Scenario")
end

Then(/^log_in form is displayed$/) do
  expect(page).to have_field("Password")
end

Given(/^log_in form has good info$/) do
  @user = User.create(email: "me@gmail.com", password: "password", name: "MyName")
  fill_in "Email", :with => "me@gmail.com"
  fill_in "Password", :with => "password"
end

And(/^session exists$/) do
  expect(page).to have_content("MyName")
end

Given(/^log_in form has bad info$/) do
  fill_in "Email", :with => "f"
end

Then(/^session is not created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^sign_up form has good info$/) do
  fill_in "Email", :with => "me@email.com"
  fill_in "Name", :with => "MyName"
  fill_in "Password", :with => "password"
  fill_in "Confirmation", :with => "password"
end

Then(/^user is created$/) do
  expect(User.find_by(email: "me@email.com")).to be_truthy
end

Then(/^info_page is displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^sign_up form has bad info$/) do
  fill_in "Email", :with => "f"
end

Then(/^user is not created$/) do
  expect(User.count).to eq(0)
end

Then(/^display login link$/) do
  expect(page).to have_link("Log in")
end

Then(/^display sign_up link$/) do
  expect(page).to have_link("Sign up")
end

Then(/^don't display new_account link$/) do
  expect(page).not_to have_link("New Account")
end

Then(/^don't display new_scenario link$/) do
  expect(page).not_to have_link("Setup Scenario")
end

Then(/^render dashboard$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^flash error 'Invalid email\/password combination'$/) do
  expect(page).to have_content("Invalid email\/password combination")
end
