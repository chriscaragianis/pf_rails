Feature: Creating new accounts

  Scenario: Visit new accounts page with no preexisting accounts
    Given Account is empty
    When a user visits accounts/new
    Then account_list is displayed
    And account_list is empty

  Scenario: Create a new account
    Given Account is empty
    When a user visits accounts/new
    And the account form is filled out
    And a user submits Save Account
    Then 1 account_box is displayed

Scenario: Create a second new account
    Given 1 Account exists
    When a user visits accounts/new
    And the account form is filled out
    And a user submits Save Account
    Then 2 account_box is displayed
