@ignore
Feature:  getlist of ngr records

  Scenario: getbrief list


    * def knownlinks = karate.jsonPath(karate.read('classpath:InspireTest/ngr/datasetrecords/def/knownlink.csv'), '[*].knownlink')
    # checking is not done here* call read('classpath:InspireTest/ngr/datasetrecords/def/checkxlinkurl.template.feature') karate.mapWithKey(knownlinks ,'link')

    * url 'http://nationaalgeoregister.nl/'


    Given path 'geonetwork/srv/dut/inspire'
    And param service = 'CSW'
    And param version = '2.0.2'
    And param request = 'GetRecords'
    And param propertyName = 'identifier'
    And param typeNames = 'csw:Record'
    And param elementsetname = "brief"
    And param resultType = 'results'
    And param startposition = 1
    And param maxRecords = 1000
    When method get
    Then status 200
    * def briefarray = get response /GetRecordsResponse/SearchResults/BriefRecord[type = 'dataset']/identifier
    * eval karate.embed( briefarray,'text/plain')
    * def list =  karate.mapWithKey(briefarray ,'datasetIdentifierCode')
    * def json = karate.map(list, function(x, i){ return {} })

   

# register.containeditems[4]["metadata-codelist"].id
# * karate.write(briefarray, 'ngrlist.json')
#[12]["metadata-codelist"].id