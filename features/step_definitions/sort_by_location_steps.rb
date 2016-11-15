When(/^I click on location$/) do
  click_link('Location')
end

Then(/^I can see the job offers sorted alphabetically by location$/) do
  page.body.index(@job_offer_two.location).should < page.body.index(@job_offer_three.location)
  page.body.index(@job_offer_three.location).should < page.body.index(@job_offer_one.location)
end
