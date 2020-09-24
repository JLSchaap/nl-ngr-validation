@ignore
Feature:  getlist of ngr records

Scenario: getbrief list

  * url 'http://nationaalgeoregister.nl/'

    Given path 'geonetwork/srv/dut/inspire'
    And param service = 'CSW'
    And param version = '2.0.2'
    And param request = 'GetRecords'
    And param propertyName = 'identifier'
    And param typeNames = 'csw:Record'
    And param elementsetname = "brief"
    And param resultType = 'results'
    And param outputFormat = 'json' 
    And param startposition = 1
    And param maxRecords = 30
    When method get
    Then status 200
     * eval karate.embed( response,'application/json')
   # * def briefarray = get response /GetRecordsResponse/SearchResults/BriefRecord[type = 'dataset']/identifier
   # * eval karate.embed( briefarray,'text/plain')
   # * def list =  karate.mapWithKey(briefarray ,'datasetIdentifierCode')
   # * def json = karate.map(list, function(x, i){ return {} })
  # * karate.write(briefarray, 'ngrlist.json')