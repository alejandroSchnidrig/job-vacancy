Given(/^that three job offers exist$/) do
  JobOffer.all.destroy
  @job_offer_one = JobOffer.new
  @job_offer_two = JobOffer.new
  @job_offer_three = JobOffer.new

  @job_offer_one.owner = User.first
  @job_offer_two.owner = User.first
  @job_offer_three.owner = User.first

  @job_offer_one.title = 'ruby'
  @job_offer_one.location = 'caseros'
  @job_offer_one.description = 'good'
  @job_offer_one.save

  @job_offer_two.title = 'python'
  @job_offer_two.location = 'caseros'
  @job_offer_two.description = 'so so'
  @job_offer_two.save

  @job_offer_three.title = 'java'
  @job_offer_three.location = 'china'
  @job_offer_three.description = 'bad'
  @job_offer_three.save
end


When(/^I do an specific search for title field$/) do
  fill_in('q', :with => 'title: ruby')
  click_button('search')
end

Then(/^i can see the offer by its title$/) do
  page.should have_content('ruby')
  page.should have_no_content('python')
  page.should have_no_content('java')
end  

When(/^I do an specific search for location field$/) do
  fill_in('q', :with => 'location: caseros')
  click_button('search')
end

Then(/^i can see the offer by its location$/) do
  page.should have_content('caseros') 
  page.should have_content('ruby')
  page.should have_content('python')
  page.should have_no_content('china')
end

When(/^I do an specific search for description field$/) do
  fill_in('q', :with => 'description: bad')
  click_button('search') 
end

Then(/^i can see the offer by its description$/) do
  page.should have_content('bad')
  page.should have_no_content('so so')
  page.should have_no_content('good')
end
