Given(/^that i am a user$/) do
  visit '/register'
  @name = 'juan perez'
  @email = 'juan.perez@gmail.com'
  @password ='juanperez2016'
  @company = 'Untref'
  fill_in('user[name]', :with => @name)
  fill_in('user[email]', :with => @email)
  fill_in('user[password]', :with => @password)
  fill_in('user[password_confirmation]', :with => @password) 
  fill_in('user[company]', :with => @company) 
  click_button('Create')
  page.should have_content('User created')
end

Given(/^I access the login page$/) do
  visit '/login'
end

When(/^I click on the recovery password button$/) do
  click_link('I forgot my password')
end

When(/^I access to the password recovery page$/) do
  visit '/users/password_recovery'
end

When(/^I put my email address$/) do
  fill_in('code_generator[user_email]', :with =>'juan.perez@gmail.com')
end

When(/^I click generate buttom$/) do
  click_button('Generate')
end  

Then(/^i can see an email with a code$/) do
  page.should have_content('Code sent')
end

When(/^I put an invalid email address$/) do
  fill_in('code_generator[user_email]', :with =>'juan.perezzzzz@gmail.com')
  click_button('Generate')
end

Then(/^i can see the error messeage$/) do
  page.should have_content('User not exist')
end
