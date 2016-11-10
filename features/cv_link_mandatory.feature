Feature: CV link mandatory in offer application
In order to add more information about me
As a user
I want to add my CV Link in an offer application

Background:
    Given that exist a job offer

Scenario: must put my CV Link in an offer application
Given I access to offers's list page
When I apply offer
Then I don't complete the cv link
Then I click apply button and see the legend CV link is mandatory
