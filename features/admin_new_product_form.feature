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
  
  Scenario: creating a new video product
      Given I am on the new video product page
      When I fill in the following:
       | Video Id                                                    | brand new event                        |
       | Embed Code | Sorry registration closed              |
       | Short Description                                      | mail us a check                        |
       | Resolution                                                    | 10.00                                  |
       | Aspect                                              | This is gonna be a great event         |
       | Map                                                  | 100 test avenue, testville, test 00000 |
       | UPC||
       |||
       |||
       |||
       |||
       |||
       |||
       |||
       |||
       |||
       |||                                       
      Then 
    
  
    
    
  
  
  
  
  
  
  
  
  

  
