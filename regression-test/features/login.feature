Feature: Login
  Verify the different users of the system have correct access

  Scenario: UGM Admin allowed access
    GIVEN a user is configured as a UGM Administrator
    AND they are logged out
    WHEN they login to the UGM Application
    THEN they can access the UGM Administrator functions

  Scenario: General user allowed access
    GIVEN a user is configured as a General UGM User
    AND they are logged out
    WHEN they login to the UGM Application
    THEN they cannot access the UGM Administrator functions

  @wip
  # Need to find out if it is possible to be denied access
  Scenario: General user denied access
    GIVEN a user is NOT configured as a General UGM User
    AND they are logged out
    WHEN they login to the UGM Application
    THEN they are denied access
