Feature: Strong password in user account
In order to guarantee a minimal security protection
As a job-vacancy user
I want to block a weak user account password in registration page


Background:
   Given i'm not a user


Scenario: Complete with a strong password the password field in registration
Given I wanna access the registration page
When I complete a field call password
Then i will be registered

Scenario: Complete with a weak password the password field in registration
Given I wanna access the registration page
When I complete the password field with a weak one
Then i can see the weak password entered legend
