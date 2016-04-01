Feature: Signing up for an account

  Scenario: Logged in user visits sign up page
    Given user logged in
    When user visits /signup
    Then dashboard is displayed

  Scenario: Visitor visits sign up page
    Given user not logged in
    When user visits /signup
    Then sign_up form is displayed

  Scenario: User signs up with good info
    Given user not logged in
    And user visits /signup
    And sign_up form has good info
    When user submits Create my account
    Then user is created
    And dashboard is displayed
    And flash success "Welcome!"

  Scenario: User signs up with bad info
    Given user not logged in
    And user visits /signup
    And sign_up form has bad info
    When user submits Create my account
    Then user is not created
    And flash error "An error occurred.  Please try again"
    And sign_up form is displayed
