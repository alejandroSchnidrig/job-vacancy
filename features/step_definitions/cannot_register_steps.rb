Given(/^that a user is signed in$/) do
  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
end

Given(/^I access the home page$/) do
  visit '/'
end

When(/^I try to access to registration page via url$/) do
  visit '/register'
end

Then(/^i can see the error message$/) do
  page.should have_content('You can not sign up if you are logged in')
end
