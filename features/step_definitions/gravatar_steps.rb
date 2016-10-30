Given(/^i am a user$/) do
    @primero = User.first
end

Given(/^I am logged$/) do
   visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

When(/^I access to the home page$/) do
  visit '/'
end

Then(/^i can see my gravatar at the top page$/) do
 page.status_code.should be 200
 page.should have_xpath('//img[@src="https://www.gravatar.com/avatar/118adc2d60d63eaa9b12b91d78531045"]')

end
