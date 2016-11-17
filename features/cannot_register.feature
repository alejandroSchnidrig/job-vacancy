Feature: User cannot register if is signed in
  In order to not register if i signed in
  As a user
  I want to not be allowed to register if i signed in

  Background:
    Given that a user is signed in

  Scenario: Try to access to registration page via url
    Given I access the home page
    When I try to access to registration page via url
    Then i can see the error message