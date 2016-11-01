When(/^I do an specific search for title field$/) do
  fill_in('q', :with => 'title: Web Programmer')
  click_button('search')
end

Then(/^i can see the offer by its title$/) do
  page.should have_content('Web Programmer')
end  

When(/^I do an specific search for location field$/) do
  fill_in('q', :with => 'location: a nice job')
  click_button('search')
end

Then(/^i can see the offer by its location$/) do
  page.should have_content('a nice job') 
end

When(/^I do an specific search for description field$/) do
  fill_in('q', :with => 'description: good pay')
  click_button('search') 
end

Then(/^i can see the offer by its description$/) do
  page.should have_content('good pay')
end
