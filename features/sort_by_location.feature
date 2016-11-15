Feature: Sort alphabetically by location 
  In order to see job offers more clearly  
  As a user
  I want to see job offer sorted alphabetically by location 


  Background:
    Given that three job offers exist


  Scenario: Sort alphabetically by location
    Given I access the offers list page
    When I click on location
    Then I can see the job offers sorted alphabetically by location