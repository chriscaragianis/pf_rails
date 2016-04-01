Feature: Dashboard page contains links to and summaries of models

  Scenario: Visitor visits dashboard
    Given user not logged in
    And user visits dashboard
    Then flash error "You must be logged in"
    And sign_up form is displayed

  Scenario: User visits dashboard
    Given user logged in
    And user has an account
    And user has a scenario
    And user visits /dashboard
    Then accounts are displayed
    And scenarios are displayed
    And new_account link is displayed
    And new_scenario link is displayed
    And run_scenario link is displayed
    
