Then /^I should see fields labeled (.+)$/ do |labels|
  labels.split(', ').each do |label|
    if defined?(Spec::Rails::Matchers)
      response.should contain(label)
    else
      assert_contain label
    end
  end
end
Given /^I am logged in as admin$/ do
  visit new_session_url
  fill_in "Login", :with => "admin"
  fill_in "Password", :with => "admin"
  click_button "Sign in" 
end
