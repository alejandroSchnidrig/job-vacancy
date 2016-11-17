Feature: Access to registration page from login page
In order to register 
As a user
I want to access to the registration page


Background:
    Given I am in the home page


Scenario: Access to registration page from login page
Given I access to the login page
When I click on singed up link
Then I access to the registration page
