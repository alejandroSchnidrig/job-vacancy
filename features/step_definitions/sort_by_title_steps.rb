When(/^I click on title$/) do
  click_link('Title')
end

Then(/^I can see the job offers sorted alphabetically by title$/) do
  page.body.index(@job_offer_three.title).should < page.body.index(@job_offer_two.title)
  page.body.index(@job_offer_two.title).should < page.body.index(@job_offer_one.title)
end
