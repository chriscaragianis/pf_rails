Then(/^"Run Scenario" is displayed$/) do
  expect(page).to have_content("Run Scenario")
end

Then(/^scenario choice is displayed$/) do
  expect(page).to have_select("Choose Scenario")
end

Then(/^"Setup Scenario" is displayed$/) do
  expect(page).to have_content("Setup Scenario")
end

