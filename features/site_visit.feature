Feature: Visiting the site

  Scenario: Visitor visits site root url
    Given user not logged in
    When user visits /
    Then display login link
    And display sign_up link
    And don't display new_account link
    And don't display new_scenario link

  Scenario: Logged in user visits site root url
    Given user logged in
    When user visits /
    Then dashboard is displayed
