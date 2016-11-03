Feature: Not share a Job offer with wrong email
  In order to not share a job offer with wrong email entered
  As a user
  I want to share an offer to a person


  Background:
    Given only a "Web Programmer" offer exists in the offers list


  Scenario: Share a job offer
    Given I access the offers list page
    When I share the offer and complete a wrong email
    Then i can see the wrong email entered legend