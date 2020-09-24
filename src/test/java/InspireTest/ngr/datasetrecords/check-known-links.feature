
Feature: check known xlinks


    Scenario Outline: check known link <knownlink>

        * def nlinks = ["<knownlink>"]
        * print nlinks
        * def title = "known url"
        * configure readTimeout = 60000
        * call read('def/checkxlinkurl.template.feature') karate.mapWithKey(nlinks ,'link')

        #    Examples:
        #        | karate.read('classpath:InspireTest/ngr/datasetrecords/def/knownlink.csv') |
        Examples:
            | knownlink                                       |
            | http://data.europa.eu/eli/reg/2010/1089         |
            | http://inspire.ec.europa.eu/id/document/tg/pipo |