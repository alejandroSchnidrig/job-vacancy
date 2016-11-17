Given(/^only a "(.*?)" offer exists in the offers list created by me$/) do |job_title|
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

  visit '/login'
  fill_in('user[email]', :with => 'juan.perez@gmail.com')
  fill_in('user[password]', :with => 'juanPerez2016')
  click_button('Login')
end

Given(/^I access the offer's list page$/) do
   visit '/job_offers/latest'
end

When(/^I click apply$/) do
  click_link 'Apply'
  fill_in('job_application[applicant_email]', :with => 'juan.perez@gmail.com')
  fill_in('job_application[link_cv]', :with => 'http:////lol')
  click_button('Apply')
end

Then(/^I should see the You can not apply to your own offer! legend$/) do
  page.should have_content('You can not apply to your own offer!')
end
