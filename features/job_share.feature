Feature: Share a Job offer
  In order to share a job offer
  As a user
  I want to share an offer to a person

  Background:
    Given only a "Web Programmer" offer exists in the offers list

  Scenario: Share a job offer
    Given I access the offers list page
    When I share the offer
    Then the person should receive a mail with the offer info