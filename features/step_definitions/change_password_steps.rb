
Given(/^I am a registered user$/) do
  @user = User.new
  @user.id = 10
  @user.name = 'Gustavo Roldan'
  @user.email = 'gus.rol@gmail.com'
  @user.password= 'Madonna2016'
  @user.company = 'UBA'
  @user.code = 'abc123'
  @user.save 
end

When(/^I click on change password button$/) do
  click_link('Change password')
end

When(/^I complete the required fields$/) do
  fill_in('user[code]', :with =>'abc123')
  fill_in('user[password]', :with =>'LebronJames2003')
  fill_in('user[password_confirmation]', :with =>'LebronJames2003')
end

When(/^I click on apply button$/) do
  click_button('Apply')
end

Then(/^I can the new password create message$/) do
  page.should have_content('New password create')
end	


Then(/^I can login with my new password$/) do
  visit '/login' 
  fill_in('user[email]', :with =>'gus.rol@gmail.com')
  fill_in('user[password]', :with =>'LebronJames2003')
  click_button('Login')
  page.should have_content('Logout')
end
