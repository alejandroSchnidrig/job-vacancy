Given(/^that exist an offer$/) do
  JobOffer.all.destroy
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'actor' 
  @job_offer.location = 'cordoba'
  @job_offer.description = 'excellent'
  @job_offer.save

  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

Given(/^I access to offers list page$/) do
    visit '/job_offers/my'
end

When(/^I clone an offer$/) do
  pending 
end

Then(/^I can see the cloned offer in the offer list page$/) do
  click_button('Clone')
  page.should have_content('copy of actor') 
  page.should have_content('copy of cordoba')
  page.should have_content('copy of excellent') 
end

