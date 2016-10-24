Given(/^i am a user$/) do
    @primero = User.first
    @primero.email
	should match("offerer@test.com")
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

Then(/^i can see my gravatar at the top page$/) do |content|
  page.should have_content(content)
end
