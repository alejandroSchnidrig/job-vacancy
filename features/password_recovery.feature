Feature: password recovery
  In order to not lose my password
  As a user
  I want to recover my password

  Background:
    Given that i am a user

  Scenario: I recover my password
    Given I access the login page
    When I click on the recovery password button
    And I access to the password recovery page
    And I put my email address
    Then i can see an email with new password