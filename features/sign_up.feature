Feature: Signing up for an account

  Scenario: Logged in user visits sign up page
    Given logged in user
    When user visits sign_up
    Then dashboard is displayed

  Scenario: Visitor visits sign up page
    Given no logged in user
    When user visits sign_up
    Then sign_up form is displayed

  Scenario: User signs up with good info
    Given user visits new_user
    And user not logged in
    And sign_up form has good info
    When user submits
    Then flash success "Welcome!"
    And user is created
    And info_page is displayed

  Scenario: User signs up with bad info
    Given user visits new_user
    And user not logged in
    And sign_up form has bad info
    When user submits
    Then user is not created
    And flash error "An error occurred.  Please try again"
    And sign_up form is displayed
