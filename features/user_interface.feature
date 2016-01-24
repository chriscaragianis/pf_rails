Feature: A user visits the site

  A user visiting the site should be presented with a "new" button
    that will reset the current data and display the first account form.
    When the form is submitted without the finish box checked, a new
    account form is displayed.  When an account form with the finish box
    checked is submitted, the run details form is displayed. When the
    run details form is submitted, the run data is calculated and displayed.

  Scenario: A user visits the site
    When a user visits the site
    Then display the new button

  Scenario: User clicks the new button
    Given a user visits the site
    When a user clicks the new button
    Then display an account form

  Scenario: User submits a form
    Given an account form is filled out
    And a user clicks add
    Then display a blank account form
