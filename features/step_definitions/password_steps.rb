require 'uri'
require 'cgi'

Given(/^i'm not a user$/) do
  @user = User.new  
end

Given(/^I wanna access the registration page$/) do
  visit '/register' 
  fill_in('user[name]', :with => 'test1')
  fill_in('user[email]', :with => 'test1@user.cc')
end

When(/^I complete a field call password$/) do
  @user_password = 'Password1234'
  fill_in('user[password]', :with => '@user_password')
  fill_in('user[password_confirmation]', :with => '@user_password')
end

Then(/^i will be registered$/) do
  click_button('Create')
  #page.should have_content('<div class="alert alert-success fade in" id="flashMessage">User created<button type="button" class="close" data-dismiss="alert">×</button></div>')
  page.should have_content('User created')
  #assert page.has_content?('User created')
end

When(/^I complete the password field with a weak one$/) do
  @user_password = '123'
  fill_in('user[password]', :with => '@user_password')
  fill_in('user[password_confirmation]', :with => '@user_password')
end

Then(/^i can see the weak password entered legend$/) do
  click_button('Create')
  page.should have_content('weak password entered')
end
