Feature: Searching

Background: Log in as a general user
    Given a user is configured as a General UGM User
    And they are logged out
    And they login to the UGM Application

Scenario: General User searches for a specific unit
    When they search for "ARC2402"
    Then "ARC2402 : 19th and 20th century architecture" appears in the search results

Scenario: General User refines a search which returns no results
    Given they select the year "2017"
    When they search for "ARC2402"
    Then "ARC2402 : 19th and 20th century architecture" does not appear in the search results

Scenario: General User refines a search which returns results
    Given they select the year "2016"
    When they search for "ARC2402"
    Then "ARC2402 : 19th and 20th century architecture" appears in the search results

Scenario: General User downloads a user guide
    Given they search for "ARC2402"
    When they download the unit guide
    Then the pdf is downloaded
