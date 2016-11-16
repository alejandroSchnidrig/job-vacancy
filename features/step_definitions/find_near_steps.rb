Given(/^that exists (\d+) jobs offers \((\d+) with same location\)$/) do |arg1, arg2|
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
  @job_offer_one.save

  @job_offer_two.title = 'president'
  @job_offer_two.location = 'usa'
  @job_offer_two.description = 'like trump'
  @job_offer_two.save

  @job_offer_three.title = 'actor'
  @job_offer_three.location = 'caseros'
  @job_offer_three.description = 'good as robert de niro'
  @job_offer_three.save
end

When(/^I click Find Near in an offer$/) do
  all(:xpath, "(//a[text()='Find Near'])")[0].click
end

Then(/^i can see the two offers with same location$/) do
  page.should have_content('caseros') 
  page.should have_content('chef')
  page.should have_content('actor')
end

Then(/^i can not see the offer with the another location$/) do
  page.should have_no_content('usa')
end

