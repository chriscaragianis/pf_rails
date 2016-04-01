Feature: Log in to an account

  Scenario: Logged in user visits log in page
    Given user logged in
    When user visits login
    Then dashboard is displayed

  Scenario: Visitor visits log in page
    Given user not logged in
    When user visits /login
    Then log_in form is displayed

  Scenario: User logs in with good info
    Given user not logged in
    And user visits /login
    And log_in form has good info
    When user submits Log in
    Then flash success "Logged in"
    And dashboard is displayed
    And session exists

  Scenario: User logs in with bad info
    Given user not logged in
    And user visits /login
    And log_in form has bad info
    When user submits Log in
    Then flash error 'Invalid email/password combination'
    And log_in form is displayed
