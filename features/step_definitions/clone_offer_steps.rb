Given(/^that exist an offer$/) do
  visit '/register'
  @name = 'juan perez'
  @email = 'juan.perez@gmail.com'
  @password ='juanPerez2016'
  @company = 'Untref'
  fill_in('user[name]', :with => @name)
  fill_in('user[email]', :with => @email)
  fill_in('user[password]', :with => @password)
  fill_in('user[password_confirmation]', :with => @password) 
  fill_in('user[company]', :with => @company) 
  click_button('Create')
  page.should have_content('User created')

  visit '/login'
  fill_in('user[email]', :with => 'juan.perez@gmail.com')
  fill_in('user[password]', :with => 'juanPerez2016')
  click_button('Login')
  page.should have_content('juan.perez@gmail.com')
  
  visit '/job_offers/new'

  fill_in('job_offer[title]', :with => 'ruby master')
  fill_in('job_offer[location]', :with => 'caseros')
  fill_in('job_offer[latitude]', :with => 1)
  fill_in('job_offer[longitude]', :with => 1)
  fill_in('job_offer[description]', :with => 'good pay')
  click_button('Create')

end

Given(/^I access to my offers list page/) do
    visit '/job_offers/my'
    page.should have_content('ruby master') 
end

When(/^I clone an offer$/) do
  click_link('Clone') 
  click_button('Save')
end

Then(/^I can see the cloned offer in my offer list page$/) do
  pending
end

