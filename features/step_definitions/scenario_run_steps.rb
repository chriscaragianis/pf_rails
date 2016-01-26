Given(/^a user at the new scenario page$/) do
  visit "scenario"
end

Then(/^scenario form is displayed$/) do
  expect(page).to have_field('name')
  expect(page).to have_field('balance')
end

Given(/^a filled out scenario form$/) do
  visit "scenario"
  fill_in 'name', with: 'test scene'
  fill_in 'start_date', with: '01/20/2016'
  fill_in 'end_date', with: '02/20/2016'
end

Given(/^the user submits Save Scenario$/) do
  click_button 'Save Scenario'
end

Then(/^the Scenario is saved$/) do
  pending # express the regexp above with the code you wish you had
end
