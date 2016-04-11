Feature: User chooses a scenario, adds accounts and generates graph

  Scenario: Visitor visits run scenario
    Given user not logged in
    And user visits /balance_records/new
    Then flash error "You must be logged in!"
    And log_in form is displayed

  Scenario: User visits run scenario with a scenario saved
    Given user logged in
    And user has a scenario
    And user visits /balance_records/new
    Then "Run Scenario" is displayed
    And scenario choice is displayed

  Scenario: User visits run scenario with no scenario saved
    Given user logged in
    And user visits /balance_records/new
    Then "Setup Scenario" is displayed
    And flash error "You must define a Scenario"

