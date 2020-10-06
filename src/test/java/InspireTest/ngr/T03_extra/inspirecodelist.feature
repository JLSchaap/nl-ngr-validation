@extra
Feature: inspire code lists


   Background:  inspire code list

      Given url 'https://inspire.ec.europa.eu/metadata-codelist/metadata-codelist.nl.json'
      When method get
      Then status 200
      * print response
      * def inspirecodelist = get response.register.containeditems[*]["metadata-codelist"].id
      * print inspirecodelist

   Scenario Outline: check <inspireCodeList>
      # https://inspire.ec.europa.eu/metadata-codelist/PriorityDataset/PriorityDataset.nl.csv
      Given url '<inspireCodeList>.nl.csv'
      When method get
      Then status 200
      * print response
      * def codelist = get response.register.containeditems[*]["metadata-codelist"].id
      * print codelist
     # Examples:
       #  | karate.mapWithKey(inspirecodelist, 'inspireCodeList') |
       Examples:
           | inspireCodeList| 
           | http://inspire.ec.europa.eu/metadata-codelist/ResourceType | 