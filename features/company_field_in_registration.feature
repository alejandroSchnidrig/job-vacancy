Feature: Company field in registration
  In order to registrate as a user
  As a job-vacancy owner
  I want to complete optionally a field call company in the registration

  Background:
  	Given i am not a user

  Scenario: Complete company field in registration
    Given I access the registration page
    When I complete optionally a field call company
    Then I can register





