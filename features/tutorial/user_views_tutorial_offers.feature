Feature: User views the offers tutorial page
  In order to learn about Sharetribe
  As a user
  I want to see the tutorial page about offers

  Scenario: User with hobbbies sees request suggestions
    Given there are following users:
      | kassi_testperson1 |
    And there are the following official hobbies:
      | name    |
      | Hobby 1 |
      | Hobby 2 |
      | Hobby 3 |
    And there are the following offer suggestions:
      | caption                    | image                      | hobby   |
      | Hobby 1 Offer suggestion 1 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Offer suggestion 2 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Offer suggestion 3 | /images/medium/missing.png | Hobby 1 |
      | Hobby 2 Offer suggestion 1 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Offer suggestion 2 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Offer suggestion 3 | /images/medium/missing.png | Hobby 2 |
      | Hobby 3 Offer suggestion 1 | /images/medium/missing.png | Hobby 3 |
      | Hobby 3 Offer suggestion 2 | /images/medium/missing.png | Hobby 3 |
      | Hobby 3 Offer suggestion 3 | /images/medium/missing.png | Hobby 3 |
    And I am logged in as "kassi_testperson1"
    And "kassi_testperson1" has the hobby "Hobby 1"
    And "kassi_testperson1" has the hobby "Hobby 2"
    When I am on the tutorial_offers page
    Then I should see "Hobby 1 Offer suggestion 1"
    And I should see "Hobby 1 Offer suggestion 2"
    And I should see "Hobby 1 Offer suggestion 3"
    And I should see "Hobby 2 Offer suggestion 1"
    And I should see "Hobby 2 Offer suggestion 2"
    And I should see "Hobby 2 Offer suggestion 3"


  Scenario: User with no hobbies sees offer suggestions
    Given there are following users:
      | kassi_testperson1 |
    And there are the following official hobbies:
      | name    |
      | Hobby 1 |
      | Hobby 2 |
      | Hobby 3 |
    And there are the following offer suggestions:
      | caption                    | image                      | hobby   |
      | Hobby 1 Offer suggestion 1 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Offer suggestion 2 | /images/medium/missing.png | Hobby 1 |
      | Hobby 1 Offer suggestion 3 | /images/medium/missing.png | Hobby 1 |
      | Hobby 2 Offer suggestion 1 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Offer suggestion 2 | /images/medium/missing.png | Hobby 2 |
      | Hobby 2 Offer suggestion 3 | /images/medium/missing.png | Hobby 2 |
    And I am logged in as "kassi_testperson1"
    When I am on the tutorial_offers page
    Then I should see "Hobby 1 Offer suggestion 1"
    And I should see "Hobby 1 Offer suggestion 2"
    And I should see "Hobby 1 Offer suggestion 3"
    And I should see "Hobby 2 Offer suggestion 1"
    And I should see "Hobby 2 Offer suggestion 2"
    And I should see "Hobby 2 Offer suggestion 3"


  Scenario: User sees latest request listings
    Given there are following users:
      | person            |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is item offer with title "Item offer 1" from "kassi_testperson2" and with share type "sell"
    And there is item offer with title "Item offer 2" from "kassi_testperson2" and with share type "sell"
    And there is item offer with title "Item offer 3" from "kassi_testperson2" and with share type "sell"
    And I am logged in as "kassi_testperson1"
    When I am on the tutorial_offers page
    Then I should see "What others are offering right now"
    And I should see "Item offer 1"
    And I should see "Item offer 2"
    And I should see "Item offer 3"


