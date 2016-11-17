Given(/^only a "(.*?)" offer exists in the offers list$/) do | job_title |
  JobOffer.all.destroy
  @job_offer = JobOffer.new
  @user = User.new
  @user.name = 'juan perez'
  @user.email = 'juan.perez@gmail.com'
  @user.password ='juanPerez2016'

  @job_offer.owner = @user
  @job_offer.title = job_title 
  @job_offer.location = 'a nice job'
  @job_offer.description = 'good pay'
  @job_offer.save
end

Given(/^I access the offers list page$/) do
  visit '/job_offers/latest'
end

When(/^I apply$/) do
  click_link 'Apply'
  fill_in('job_application[applicant_email]', :with => 'applicant@test.com')
  fill_in('job_application[link_cv]', :with => 'http:////lol')
  click_button('Apply')
end

Then(/^I should receive a mail with offerer info$/) do
  page.should have_content('Contact information sent')
end

