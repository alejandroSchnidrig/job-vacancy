When(/^I share the offer and complete a wrong email$/) do
  click_link 'Share'
  @job_sharing_comments = 'user comments'
  fill_in('job_sharing[contact_email]', :with => 'nnn')
  fill_in('job_sharing[comments]', :with => @job_sharing_comments)
  click_button('Send')
end

Then(/^i can see the wrong email entered legend$/) do
  page.should have_content('Invalid email direction')
end
