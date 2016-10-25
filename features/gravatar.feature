Feature: See my gravatar at the top page
In order to identify me with a picture
As a user
I want to see my gravatar at the top page 

Background:
    Given i am a user

Scenario: See my gravatar at the top page
Given I am logged
When I access to the home page
Then i can see my gravatar at the top page
