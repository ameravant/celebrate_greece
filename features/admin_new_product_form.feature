Feature: Admin new video product form
  In order to create a new video product  
  As an admin
  I want to see the correct fields
  
  Background:
   Given I am logged in as admin
   And I am on the homepage
  Scenario: browsing to the form
    When I follow "Products"
    And I follow "Add a video product"
    Then I should be on the new video product page
    Then I should see fields labeled Video ID, Embed Code, Short Description, Resolution, Aspect, Map, UPC, Producer, VOD, Video Length, Trailer Length, Subtitled, Country, Region, Tags, Purchase Options
    And I should see "Feature on main products page."
  @fill
  Scenario: creating a new video product
      Given I am on the new video product page
      # Then I should see "jason is awesome"
      When I fill in the following:
       | Name:             | new video             |
       | Video ID:         | 123244                |
       | Embed Code        | 6544555               |
       | Short Description: | this is a great video |
       | Resolution        | 750x839               |
       | Aspect            | 9:45                  |
       | Map               | yadda                 |
       | UPC               | 12345                 |
       | VOD:              | 1234                  |
       | Video Length:     | 123                   |
       | Trailer Length:   | 1:23:33               |
       | Subtitled:        | false                 |
       | Country           | us                    |
       | Tags              | tag, tags, more, tags |
       | Mobile Video      | http://www.blah.com   |
       | Itunes            |                       |
       | Dvd               | http://www.blah.com   |
      And I check "Feature on main products page."
      And I press "Save Product"
      Then I should be on the admin product index page
      And I should see "new video" 
      When I follow "Delete new video"
      And I follow "Products"
      # Then I should not see "new video"
    
  
    
    
  
  
  
  
  
  
  
  
  

  
