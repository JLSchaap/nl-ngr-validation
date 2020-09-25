<!-- omit in toc -->
# Nl-ngr-validation
Nl-ngr-validation is a testsuite with Java, Maven and [Karate](https://github.com/intuit/karate) to validate [Inspire] (https://inspire-geoportal.ec.europa.eu/index.html) metadata from the [Dutch geoportal](https://www.nationaalgeoregister.nl/) 

- [1. Running the tests](#1-running-the-tests)
- [2. Tests](#2-tests)
  - [2.1. Get list from Inspire endpoint](#21-get-list-from-inspire-endpoint)
  - [2.2. Link checking](#22-link-checking)


# 1. Running the tests
Test are run with the following commands:

``` bash
git clone https://github.com/JLSchaap/nl-ngr-validation
mvn test
```

A [cucumber test report](
https://jlschaap.github.io/nl-ngr-validation/cucumber-html-reports/overview-features.html) shows the status last run
# 2. Tests
## 2.1. Get list from Inspire endpoint
The following test are done 

T1 Inspire endpoint gives list of Inspire datasets and services
This is tested by [ngr-check-dataset-record.feature](https://raw.githubusercontent.com/JLSchaap/nl-ngr-validation/master/src/test/java/InspireTest/ngr/datasetrecords/ngr-check-dataset-record.feature)

The following list are generated in csv format: 
- [datasets](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/datasets.csv)
- [services](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/services.csv)




## 2.2. Link checking
A list of [knownlinks](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/java/InspireTest/ngr/datasetrecords/def/knownlink.csv) is used to speed up the link checking. 
This [knownlinks](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/java/InspireTest/ngr/datasetrecords/def/knownlink.csv) is validated with [check-known-links.feature](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/java/InspireTest/ngr/datasetrecords/check-known-links.feature)

All checked links are recorded in [foundlink.csv](
https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/foundlink.csv)