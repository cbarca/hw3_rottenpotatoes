# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @movie = Movie.create!(movie) 
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  pos_e1 = page.body.index(e1)
  pos_e2 = page.body.index(e2)
  pos_e1.should < pos_e2
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split.each do |rating|
    uncheck("ratings_#{rating}") if uncheck
    check("ratings_#{rating}") if !uncheck
  end
end

When /I check all the ratings/ do 
  step "I check the following ratings: G R PG-13 PG NC-17"
end

When /I uncheck all the ratings/ do 
   step "I uncheck the following ratings: G R PG-13 PG NC-17"
end

Then /I should see (.*) movies/ do |movies_number|
  actual_number = page.all('table#movies tr').count
  actual_number.should == movies_number.to_i + 1
end

