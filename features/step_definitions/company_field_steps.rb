Given(/^i am not a user$/) do
  @user = User.new  
end

Given(/^I access the registration page$/) do
  visit '/register' 
end

When(/^I complete optionally a field call company$/) do
  @user_company = 'the company'
  fill_in('user[company]', :with => '@user_company')
end

Then(/^I can register$/) do
  click_button('Create')
end

