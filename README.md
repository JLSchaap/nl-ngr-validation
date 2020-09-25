<!-- omit in toc -->
# Nl-ngr-validation
Nl-ngr-validation is a testsuite with Java, Maven and [Karate](https://github.com/intuit/karate) to validate [Inspire] (https://inspire-geoportal.ec.europa.eu/index.html) metadata from the [Dutch geoportal](https://www.nationaalgeoregister.nl/) 

- [1. Running the tests](#1-running-the-tests)
- [2. Tests](#2-tests)
  - [2.1. Get list from Inspire endpoint (step1)](#21-get-list-from-inspire-endpoint-step1)
  - [2.2. Link checking (step2)](#22-link-checking-step2)
  - [2.3 Extra](#23-extra)
  - [2.4 Regresion](#24-regresion)


# 1. Running the tests
Test are run with the following commands:

``` bash
git clone https://github.com/JLSchaap/nl-ngr-validation
mvn test
```

# 2. Tests
The following test are done: 
## 2.1. Get list from Inspire endpoint (step1)


T1 Inspire endpoint gives list of Inspire datasets and services
This is tested by [ngr-check-dataset-record.feature](https://raw.githubusercontent.com/JLSchaap/nl-ngr-validation/master/src/test/java/InspireTest/ngr/datasets/ngr-check-dataset-record.feature)

The following list are generated in csv format during [regression](##-2.4-Regresion): 
- [datasets](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/datasets.csv)
- [services](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/services.csv)

## 2.2. Link checking (step2)  
A list of [knownlinks](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/java/InspireTest//def/knownlink.csv) is used to speed up the link checking. 
This [knownlinks](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/java/InspireTest/ngr/def/knownlink.csv) is validated with [check-known-links.feature](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/java/InspireTest/ngr/links/check-known-links.feature)


All checked links are recorded in [foundlink.csv](
https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/foundlink.csv)

## 2.3 Extra
Some extra tests are run to see the status of the [Dutch geoportal](https://www.nationaalgeoregister.nl/) and the [Inspire geoportal](https://inspire-geoportal.ec.europa.eu)


## 2.4 Regresion 
The test are run as [github action]([https://github.com/JLSchaap/nl-ngr-validation/actions
) on a requlair base. 
A [cucumber test report](
https://jlschaap.github.io/nl-ngr-validation/cucumber-html-reports/overview-features.html) shows the status![Always failing?](https://github.com/JLSchaap/nl-ngr-validation/workflows/NGR%20validatie/badge.svg) of the last run
Results are stored in [github pages](https://github.com/JLSchaap/nl-ngr-validation/tree/gh-pages)