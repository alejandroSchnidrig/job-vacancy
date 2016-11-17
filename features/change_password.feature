Feature: Change password
  In order to have the new password that i want 
  As a user
  I want to change my password when i recover it


  Background:
    Given I am a registered user


  Scenario: change my password
    Given I access the login page
    And I click on the recovery password button
    And I access to the password recovery page
    And I click on change password button
    And I complete the required fields
    When I click on apply button
    Then I can the new password create message
    Then I can login with my new password
