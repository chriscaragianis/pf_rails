Feature: User creates and runs a scenario on a set of accounts

  Scenario: User enters scenario info
    Given a user at the new scenario page
    Then scenario form is displayed

  Scenario: User submits scenario info
    Given accounts exist
    And a user at the new scenario page
    And a filled out Scenario form
    And a user button clicks submit 
    Then a results page is displayed
    And the results are correct
