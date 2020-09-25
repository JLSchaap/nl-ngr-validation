
Feature:  get services

    Scenario: getdatasets
        Given url 'https://jlschaap.github.io/nl-ngr-validation/services.csv'
        When method get
        Then status 200

