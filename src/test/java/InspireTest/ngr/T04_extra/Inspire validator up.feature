@step3

Feature: Inspire ETF Service is up and running

  Background:
    * url 'https://inspire.ec.europa.eu/validator/v2/'

  Scenario: Healt
    Given path 'heartbeat'
    When method HEAD
    Then assert responseStatus == 200 || responseStatus == 204
    * print responseStatus

  Scenario: Check the status of the service, i.e. if there is thread run available
    Given path 'status'
    When method GET
    Then status 200
    And match response.status == "GOOD"

  Scenario: list test suites
    Given path 'ExecutableTestSuites.json'
    And param fields = "id,label"
    When method GET
    Then status 200
    * print response

  Scenario: Check test suites atom exits
    Given path 'ExecutableTestSuites/EID11571c92-3940-4f42-a6cd-5e2b1c6f4d93'

    When method HEAD
    Then status 204


  
