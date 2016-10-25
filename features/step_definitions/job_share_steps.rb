Given(/^that exist a job offer$/) do
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'Chef'
  @job_offer.location = 'Caseros'
  @job_offer.description = 'Excellent pay'
  @job_offer.save
end

When(/^I share the offer$/) do
  click_link 'Share'
  @job_sharing_comments = 'user comments'
  fill_in('job_sharing[contact_email]', :with => 'applicant@test.com')
  fill_in('job_sharing[comments]', :with => '@job_sharing_comments')
  click_button('Send')
end

Then(/^the person should receive a mail with the offer info$/) do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/applicant@test.com", "r")
  content = file.read
  content.include?(@job_offer.title).should be true
  content.include?(@job_offer.location).should be true
  content.include?(@job_offer.description).should be true
  content.include?(@job_offer.owner.email).should be true
  content.include?(@job_offer.owner.name).should be true
end
