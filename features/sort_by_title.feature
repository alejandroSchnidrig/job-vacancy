Feature: Sort alphabetically by title 
  In order to see job offers more clearly  
  As a user
  I want to see job offer sorted alphabetically by title 


  Background:
    Given that three job offers exist


  Scenario: Sort alphabetically by title
    Given I access the offers list page
    When I click on title
    Then I can see the job offers sorted alphabetically by title