Feature: Find Near offers to same location
In order to search multiple offers in Near Location
As a user
I want to Find Near offers to same location


Background:
    Given that exists 3 jobs offers (2 with similar gps coordinates)


Scenario: Find Near offers to same location
Given I access the offers list page
When I wanna click Find Near in an offer
Then i  can see the two offers with same location
Then i  can not see the offer with the another location
