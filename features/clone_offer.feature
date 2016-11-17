Feature: Clone an offer
In order create a new offer
As a user
I want to clone an existing offer 


Background:
    Given that exist an offer


Scenario: clone an offer
Given I access to my offers list page
When I clone an offer
Then I can see the cloned offer in my offer list page

