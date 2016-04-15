Given(/^new_scenario form has bad info$/) do
  fill_in "Name", :with => ""
end

Given(/^new_scenario form has good info$/) do
  fill_in "Name", :with => "Scenario"
  fill_in "Vest level", :with => "100"
end

Then(/^scenario is not created$/) do
  expect(Scenario.count).to eq(0)
end

Then(/^new_scenario form is displayed$/) do
  expect(page).to have_content("Vest level")
end

Then(/^scenario is created$/) do
  expect(Scenario.find_by(name: "Scenario")).to be_truthy 
end

