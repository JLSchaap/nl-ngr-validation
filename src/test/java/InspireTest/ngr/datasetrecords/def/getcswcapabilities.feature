
Feature:  get csw capabilities

  Scenario Outline: get capabilities <cswurl>



    Given url <cswurl>
    And param service = 'CSW'
    And param version = '2.0.2'
    And param request = 'GetCapabilities'
    When method get
    Then status 200
    * eval karate.embed( response,'application/json')
    # * def briefarray = get response /GetRecordsResponse/SearchResults/BriefRecord[type = 'dataset']/identifier
    # * eval karate.embed( briefarray,'text/plain')
    # * def list =  karate.mapWithKey(briefarray ,'datasetIdentifierCode')
    # * def json = karate.map(list, function(x, i){ return {} })
    # * karate.write(briefarray, 'ngrlist.json')
    Examples:
      | cswurl                                                                                 |
      | 'https://inspire-geoportal.ec.europa.eu/GeoportalProxyWebServices/resources/OGCCSW202' |
      | 'http://nationaalgeoregister.nl/geonetwork/srv/dut/inspire'                            |