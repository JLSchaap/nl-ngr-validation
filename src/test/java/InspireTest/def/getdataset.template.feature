
Feature:  get datasets

    Scenario: getdatasets
        Given url 'https://jlschaap.github.io/nl-ngr-validation/datasets.csv'
        When method get
        Then status 200

