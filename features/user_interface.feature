Feature: A user visits the site

  A user visiting the site should be presented with a "new" button
    that will reset the current data and display the first account form.
    When the form is submitted without the finish box checked, a new
    account form is displayed.  When an account form with the finish box
    checked is submitted, the run details form is displayed. When the
    run details form is submitted, the run data is calculated and displayed.

  Scenario: A user visits the site
    When a user visits the site
    Then display the Start link

  Scenario: User clicks the Start button
    Given a user visits the site
    When a user clicks Start
    Then display an account form
    And the db is cleared

  Scenario: User submits a form
    Given a user visits the site
    And a user clicks Start
    And the form is filled out
    And a user submits Save Account
    Then an Account is saved
    And add another is displayed
    And finish is displayed

  Scenario: User adds another Account
    Given a user visits the site
    And a user clicks Start
    And the form is filled out
    And a user submits Save Account
    And a user clicks Add Another
    Then display an account form

  Scenario: User finishes adding Accounts
    Given a user visits the site
    And a user clicks Start
    And the form is filled out
    And a user submits Save Account
    And a user clicks Done with accounts
    Then list accounts
    And Run Scenario is displayed
