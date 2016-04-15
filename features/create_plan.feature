Feature: Scenario creation

  Scenario: Visitor visits scenario/new
    Given user not logged in
    And user visits /scenarios/new
    Then flash error "You must be logged in!"
    And sign_up form is displayed

  Scenario: User creates an scenario with bad info
    Given user logged in
    And user visits /scenarios/new
    And new_scenario form has bad info
    When user submits Save Scenario
    Then scenario is not created
    And flash error "An error occurred, please try again"
    And new_scenario form is displayed

  Scenario: User creates an scenario with good info
    Given user logged in
    And user visits /scenarios/new
    And new_scenario form has good info
    When user submits Save Scenario
    Then scenario is created
    And flash success
    And dashboard is displayed
