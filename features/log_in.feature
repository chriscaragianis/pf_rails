Feature: Log in to an account

  Scenario: Logged in user visits log in page
    Given logged in user
    When user visits log_in
    Then dashboard is displayed

  Scenario: Visitor visits log in page
    Given no logged in user
    When user visits log_in
    Then log_in form is displayed

  Scenario: User logs in with good info
    Given user visits log_in
    And user not logged in
    And log_in form has good info
    When user submits
    Then flash success "Logged in"
    And session is created
    And dashboard is displayed

  Scenario: User logs in with bad info
    Given user visits log_in 
    And user not logged in
    And log_in form has bad info
    When user submits
    Then session is not created
    And flash error "An error occurred.  Please try again"
    And log_in form is displayed
