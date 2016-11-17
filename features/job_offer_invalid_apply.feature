Feature: Job Application
  In order to get a job
  As a user
  I do not want to apply to my offers

  Background:
  	Given only a "Web Programmer" offer exists in the offers list created by me

  Scenario: Do not apply to job offer
    Given I access the offer's list page
    When I click apply
    Then I should see the You can not apply to your own offer! legend

  
