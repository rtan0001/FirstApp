Feature: perform initial system sanity checks

  @pvt
  Scenario: ensure server is available
     Given we are validating the system
      when we load the homepage
      then the server will respond

  @pvt
  Scenario: ensure healthcheck is valid
     Given we are validating the system
      when we load the health check
      then the server will respond successfully
