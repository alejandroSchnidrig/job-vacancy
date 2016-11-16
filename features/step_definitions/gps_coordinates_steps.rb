Given(/^that exists (\d+) jobs offers \((\d+) with similar gps coordinates\)$/) do |arg1, arg2|
  JobOffer.all.destroy
  @job_offer_one = JobOffer.new
  @job_offer_two = JobOffer.new
  @job_offer_three = JobOffer.new

  @job_offer_one.owner = User.first
  @job_offer_two.owner = User.first
  @job_offer_three.owner = User.first

  @job_offer_one.title = 'chef'
  @job_offer_one.location = 'caseros'
  @job_offer_one.description = 'french food'
  @job_offer_one.latitude = -37.5
  @job_offer_one.longitude = -58.8
  @job_offer_one.save

  @job_offer_two.title = 'actor'
  @job_offer_two.location = 'caseros city'
  @job_offer_two.description = 'like trump'
  @job_offer_one.latitude = -37.4
  @job_offer_one.longitude = -58.9
  @job_offer_two.save

  @job_offer_three.title = 'stripper'
  @job_offer_three.location = 'new york'
  @job_offer_three.description = 'good as robert de niro'
  @job_offer_one.latitude = -36.5
  @job_offer_one.longitude = -58.8
  @job_offer_three.save
end

When(/^I wanna click Find Near in an offer$/) do
  all(:xpath, "(//a[text()='Find Near'])")[0].click
end

Then(/^i  can see the two offers with same location$/) do
  page.should have_content('caseros') 
  page.should have_content('caseros city') 
  page.should have_content('chef')
  page.should have_content('actor')
end

Then(/^i  can not see the offer with the another location$/) do
  page.should have_no_content('new york')
end

