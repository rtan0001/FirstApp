# Automated regression tests

This package exists to create a suite of automated regression tests for the UGM application.

The tools in use for this are:

 - python
 - behave
 - selenium
 - chrome webdriver

## Setup on Windows



## Setup (on OSX)

Install a python virtualenv

```
virtualenv behave-venv
source behave-venv/bin/activate
```

Install the project dependancies

```
pip install -r requirements.txt
```

Install the chrome driver

```
brew install chromedriver
```

## Running the tests

```
behave
```

## Running failed tests

There may be times when a specific test fails when running a test suite.

For example, running the tests with `behave` you might get the following output.

```
Failing scenarios:
  features/login.feature:16  General user denied access
```

You can re-run the entire test suite again, but this may take a long time (if there are lots of tests), or you can instruct *behave* to only run the specific test.

After fixing the test, or solving the issue with the application you can run a specific test with `behave <feature>`  for example `behave features/login.feature:16`:

An execution of behave will show as follows:

```
behave features/login.feature:16
Feature: Login # features/login.feature:1
  As users of the UET system
  Scenario: MUOLT admin allowed access                      # features/login.feature:4
    Given a user is configured as a UET MUOLT Administrator # None
    And they are logged out                                 # None
    When they login to the UET Application                  # None
    Then they can access the UET Administrator functions    # None

  Scenario: Faculty admin user allowed access               # features/login.feature:10
    Given a user is configured as a UET Faculty Admin       # None
    And they are logged out                                 # None
    When they login to the UET Application                  # None
    Then they cannot access the UET Administrator functions # None

  Scenario: General user denied access                          # features/login.feature:16
    Given a user is NOT configured as a UET MUOLT Administrator # features/steps/login.py:18 0.000s
    And they are logged out                                     # features/steps/login.py:3 0.425s
    When they login to the UET Application                      # features/steps/login.py:23 4.145s
    Then they are denied access.                                # features/steps/login.py:49 0.005s

1 feature passed, 0 failed, 0 skipped
1 scenario passed, 0 failed, 2 skipped
4 steps passed, 0 failed, 8 skipped, 0 undefined
```

You can see that on this run the 1 feature selected has executed, but 2 have been skipped.

## Developing tests

http://selenium-python.readthedocs.io/api.html
