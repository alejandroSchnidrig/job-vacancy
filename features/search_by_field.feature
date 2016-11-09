Feature: specify search field
  In order to search a specific field in an offer
  As a user
  I want to specify the field in the search bar


  Background:
    Given that three job offers exist


  Scenario: specify search field by title field
    Given I access the offers list page
    When I do an specific search for title field
    Then i can see the offer by its title


  Scenario: specify search by location field
    Given I access the offers list page
    When I do an specific search for location field
    Then i can see the offer by its location


  Scenario: specify search by description field
    Given I access the offers list page
    When I do an specific search for description field
    Then i can see the offer by its description
