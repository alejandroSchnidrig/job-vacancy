Given(/^i'm not a user$/) do
  @user = User.new  
end

Given(/^I wanna access the registration page$/) do
  visit '/register' 
end

When(/^I complete a field call password$/) do
  @user_password = 'Password123'
  fill_in('user[password]', :with => '@user_password')
end

Then(/^i will be registered$/) do
  click_button('Create')
end

