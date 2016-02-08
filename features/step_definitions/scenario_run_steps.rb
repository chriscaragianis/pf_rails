Given(/^a user at the new scenario page$/) do
  visit "scenario"
end

Then(/^scenario form is displayed$/) do
  expect(page).to have_field('name')
  expect(page).to have_field('balance')
end

Given(/^a filled out scenario form$/) do
  fill_in 'name', with: 'test scene'
  fill_in 'start_day', with: '01-20-2016'
  fill_in 'finish_day', with: '02-20-2016'
end

Given(/^the user submits Setup Scenario$/) do
  click_button 'submit'
end

Then(/^the Scenario is saved$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^accounts exist$/) do
  Account.delete_all
  Account.new(balance: 0, weekly: true, week_offset: 0, week_period: 1, day: 5, fixed_amount: -100).save
  Account.new(carry_balance: true, balance: -200, day: 24, min_rate: -0.02, rate: 0.25).save
  Account.new(carry_balance: true, balance: -400, day: 22, fixed_amount: 100, rate: 0.06).save
end

Given(/^a filled out Scenario form$/) do
  visit "scenario"
  fill_in 'name', with: 'test scene'
  fill_in 'start_day', with: '2016-01-20'
  fill_in 'finish_day', with: '2016-02-19'
  fill_in 'vest_level', with: '600'
  fill_in 'start_balance', with: '500'
end

Then(/^a results page is displayed$/) do
  expect(page).to have_content("RESULTS")
end

Then(/^the results are correct$/) do
  expect(page).to have_content("Balance: 196.88292069531627 NAME: 0.0, NAME: 0.0,")
end
