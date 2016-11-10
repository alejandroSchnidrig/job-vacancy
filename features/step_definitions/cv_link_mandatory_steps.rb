Given(/^that exist a job offer$/) do
  JobOffer.all.destroy
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'cocinero' 
  @job_offer.location = 'a nice job'
  @job_offer.description = 'good pay'
  @job_offer.save
end

Given(/^I access to offers's list page$/) do
    visit '/job_offers/latest'
end

When(/^I apply offer$/) do
  click_link 'Apply'
end

Then(/^I don't complete the cv link$/) do
  
  fill_in('job_application[applicant_email]', :with => 'applicant@test.com')
end

Then(/^I click apply button and see the legend CV link is mandatory$/) do
  click_button('Apply')
  page.should have_content('CV link is mandatory')
end
