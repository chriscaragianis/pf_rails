Feature: User creates and runs a scenario on a set of accounts

  Scenario: User enters scenario info
    Given a user at the new scenario page
    Then scenario form is displayed

  Scenario: User submits scenario info
    Given a filled out scenario form
    And the user submits Save Scenario
    Then a results page is displayed
