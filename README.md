<!-- omit in toc -->
# Nl-ngr-validation
Nl-ngr-validation is a testsuite with Java, Maven and [Karate](https://github.com/intuit/karate) to extract [Inspire](https://inspire-geoportal.ec.europa.eu/index.html) metadata from the [Dutch geoportal](https://www.nationaalgeoregister.nl/) 

- [1. Running the tests](#1-running-the-tests)
- [2. Tests](#2-tests)
  - [2.1. Get list from Inspire endpoint](#21-get-list-from-inspire-endpoint)
  - [2.2 Regresion](#22-regresion)



# 1. Running the tests
Test are run with the following commands:

``` bash
git clone https://github.com/JLSchaap/nl-ngr-validation
mvn test
```

For docker user there is a [shell script](mavenCleanTest.sh) to run the testsuite



# 2. Tests
The following test are done: 
## 2.1. Get list from Inspire endpoint 


T1 Inspire endpoint gives list of Inspire datasets and services


The following list are generated in csv format during [regression](##-2.4-Regresion): 
- [datasets](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T02_Datasets/datasets.csv)
- [services](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T02_Services/services.csv)
- [services for each provider](https://github.com/JLSchaap/nl-ngr-validation/tree/gh-pages/T02_Services) e.g. [services-Beheer PDOK](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T02_Services/services-Beheer%20PDOK.csv) 


## 2.2 Regresion 
The test are run as [github action]([https://github.com/JLSchaap/nl-ngr-validation/actions
) on a requlair base. 
A [cucumber test report](
https://jlschaap.github.io/nl-ngr-validation/cucumber-html-reports/overview-features.html) shows the status![Always failing?](https://github.com/JLSchaap/nl-ngr-validation/workflows/NGR%20validatie/badge.svg) of the last run
Results are stored in [github pages](https://github.com/JLSchaap/nl-ngr-validation/tree/gh-pages)