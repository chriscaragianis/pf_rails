Feature: Account creation

  Scenario: Visitor visits new_account_path
    Given user not logged in
    And user visits /accounts/new
    Then flash error "You must be logged in!"
    And sign_up form is displayed

  Scenario: User creates an account with bad info
    Given user logged in
    And user visits /accounts/new
    And new_account form has bad info
    When user submits Save Account
    Then account is not created
    And flash error "An error occurred, please try again"
    And new_account form is displayed

  Scenario: User creates an account with good info (create another)
    Given user logged in
    And user visits /accounts/new
    And new_account form has good info
    And done is not checked
    When a user submits Save Account
    Then account is created
    And flash success
    And new_account form is displayed

  Scenario: User creates an account with good info (done)
    Given user logged in
    And user visits /accounts/new
    And new_account form has good info
    And done is checked
    When a user submits Save Account
    Then account is created
    And flash success
    And dashboard is displayed
