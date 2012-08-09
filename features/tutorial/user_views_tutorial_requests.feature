Feature: User views the requests tutorial page
  In order to learn about Sharetribe
  As a user
  I want to see the tutorial page about requests

  Scenario: User with hobbbies sees request suggestions
    Given there are following users:
      | kassi_testperson1 |
    And there are the following official hobbies:
      | name    |
      | Hobby 1 |
      | Hobby 2 |
      | Hobby 3 |
    And there are the following request suggestions:
      | caption                      | image                      | hobby   |
      | Hobby 1 Request suggestion 1 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Request suggestion 2 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Request suggestion 3 | /images/medium/missing.png | Hobby 1 |
      | Hobby 2 Request suggestion 1 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Request suggestion 2 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Request suggestion 3 | /images/medium/missing.png | Hobby 2 |
      | Hobby 3 Request suggestion 1 | /images/medium/missing.png | Hobby 3 |
      | Hobby 3 Request suggestion 2 | /images/medium/missing.png | Hobby 3 |
      | Hobby 3 Request suggestion 3 | /images/medium/missing.png | Hobby 3 |
    And I am logged in as "kassi_testperson1"
    And "kassi_testperson1" has the hobby "Hobby 1"
    And "kassi_testperson1" has the hobby "Hobby 2"
    When I am on the tutorial_requests page
    Then I should see "Hobby 1 Request suggestion 1"
    And I should see "Hobby 1 Request suggestion 2"
    And I should see "Hobby 1 Request suggestion 3"
    And I should see "Hobby 2 Request suggestion 1"
    And I should see "Hobby 2 Request suggestion 2"
    And I should see "Hobby 2 Request suggestion 3"


  Scenario: User with no hobbies sees request suggestions
    Given there are following users:
      | kassi_testperson1 |
    And there are the following official hobbies:
      | name    |
      | Hobby 1 |
      | Hobby 2 |
      | Hobby 3 |
    And there are the following request suggestions:
      | caption                      | image                      | hobby   |
      | Hobby 1 Request suggestion 1 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Request suggestion 2 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Request suggestion 3 | /images/medium/missing.png | Hobby 1 |
      | Hobby 2 Request suggestion 1 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Request suggestion 2 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Request suggestion 3 | /images/medium/missing.png | Hobby 2 |
    And I am logged in as "kassi_testperson1"
    When I am on the tutorial_requests page
    Then I should see "Hobby 1 Request suggestion 1"
    And I should see "Hobby 1 Request suggestion 2"
    And I should see "Hobby 1 Request suggestion 3"
    And I should see "Hobby 2 Request suggestion 1"
    And I should see "Hobby 2 Request suggestion 2"
    And I should see "Hobby 2 Request suggestion 3"


  Scenario: User sees latest request listings
    Given there are following users:
      | person            |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is item request with title "Item request 1" from "kassi_testperson2" and with share type "buy"
    And there is item request with title "Item request 2" from "kassi_testperson2" and with share type "buy"
    And there is item request with title "Item request 3" from "kassi_testperson2" and with share type "buy"
    And I am logged in as "kassi_testperson1"
    When I am on the tutorial_requests page
    Then I should see "What others are requesting right now"
    And I should see "Item request 1"
    And I should see "Item request 2"
    And I should see "Item request 3"


