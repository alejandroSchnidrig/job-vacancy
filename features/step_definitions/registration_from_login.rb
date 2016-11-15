Given(/^I am in the home page$/) do
  visit '/'
end

Given(/^I access to the login page$/) do
  visit '/login'
end

When(/^I click on singed up link$/) do
  click_link('Sign Up')
end

Then(/^I access to the registration page$/) do
  visit '/register'
end

