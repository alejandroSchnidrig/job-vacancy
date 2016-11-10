When(/^I share the offer$/) do
  all(:xpath, "(//a[text()='Share'])")[1].click
  @job_sharing_comments = 'user comments'
  fill_in('job_sharing[contact_email]', :with => 'applicant@test.com')
  fill_in('job_sharing[comments]', :with => @job_sharing_comments)
  click_button('Send')
end

Then(/^the person should receive a mail with the offer info$/) do
  page.should have_content('Offer information sent')
end