
Given /^there are the following official hobbies:$/ do |table|
  table.hashes.each do |hash|
    Factory(:hobby,
      :name => hash['name'],
      :official => true
    )
  end
end

Given /^there are the following (request|offer) suggestions:$/ do |type, table|
  table.hashes.each do |hash|
    Factory(:action_suggestion,
      :caption => hash['caption'],
      :image => hash['image'],
      :action_type => type,
      :hobby_id => Hobby.find_by_name(hash['hobby']).id
    )
  end
end

Given /^"([^"]*)" has the hobby "([^"]*)"$/ do |username, hobby|
  Person.find_by_username(username).hobbies << Hobby.find_by_name(hobby)
end
