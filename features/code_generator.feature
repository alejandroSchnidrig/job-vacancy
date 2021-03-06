Feature: code generator for password recover
  In order to not lose my password
  As a user
  I want to recover my password

  Background:
    Given that i am a user

  Scenario: generate code for recover my password
    Given I access the login page
    When I click on the recovery password button
    And I access to the password recovery page
    And I put my email address
    And I click generate buttom
    Then i can see an email with a code

  Scenario: Not user exist
    Given I access the login page
    When I click on the recovery password button
    And I access to the password recovery page
    And I put an invalid email address
    Then i can see the error messeage  