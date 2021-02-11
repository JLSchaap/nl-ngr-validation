<!-- omit in toc -->
# Nl-ngr-validation
Nl-ngr-validation is a testsuite with Java, Maven and [Karate](https://github.com/intuit/karate) to extract [Inspire](https://inspire-geoportal.ec.europa.eu/index.html) metadata from the [Dutch geoportal](https://www.nationaalgeoregister.nl/) 

- [1. Running the tests](#1-running-the-tests)
- [2. Generated lists](#2-generated-lists)
  - [2.1. Get list from Inspire endpoint](#21-get-list-from-inspire-endpoint)
  - [2.2 Regresion](#22-regresion)



# 1. Running the tests
Test are run with the following commands:

``` bash
git clone https://github.com/JLSchaap/nl-ngr-validation
mvn test
```

For docker user there is a [shell script](mavenCleanTest.sh) to run the testsuite



# 2. Generated lists 

## 2.1. Get list from Inspire endpoint 


By calling [the NGR Inspire CSW endpoint](https://www.nationaalgeoregister.nl/geonetwork/srv/dut/catalog.search#/metadata/deb81ebe-c7a7-42ba-bc21-f07cd348c3e8) and matching dataset and service metadata information is created. 


The following list are generated in csv format during [regression](##-2.4-Regresion): 
- [datasets](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T02_Datasets/datasets.csv)

- [datasets with related services en serviceorganisation](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T03_harvestEval/datasetsmetservices.csv)- 
- [services](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T02_Services/services.csv)
- [services for each provider](https://github.com/JLSchaap/nl-ngr-validation/tree/gh-pages/T02_Services) e.g. [services-Beheer PDOK](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T02_Services/services-Beheer%20PDOK.csv) 
- [services without matching Inspire dataset](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T03_harvestEval/datasetsmetserviceserror.csv)
-   [harvest extra](https://github.com/JLSchaap/nl-ngr-validation/blob/gh-pages/T03_harvestEval/INSPIREGeoportalHarvestExtra.csv) a csv file with extra information added to [Geonovum harvest csv](https://github.com/JLSchaap/nl-ngr-validation/blob/master/src/test/resources/INSPIREGeoportalHarvest.csv) 

## 2.2 Regresion 
The test are run as [github action]([https://github.com/JLSchaap/nl-ngr-validation/actions
) on a requlair base. 
A [cucumber test report](
https://jlschaap.github.io/nl-ngr-validation/cucumber-html-reports/overview-features.html) shows the status![Always failing?](https://github.com/JLSchaap/nl-ngr-validation/workflows/NGR%20validatie/badge.svg) of calling the NGR CSW endpoint in the last run.
Results are stored in [github pages](https://github.com/JLSchaap/nl-ngr-validation/tree/gh-pages)
