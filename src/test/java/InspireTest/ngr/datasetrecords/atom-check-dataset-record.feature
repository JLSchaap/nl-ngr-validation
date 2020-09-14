
@service=ATOM

Feature:  Check dataset record datasetIdentifierCode
  Background:
    * configure readTimeout = 30000
    * configure connectTimeout = 30000

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
    #* eval karate.embed(responseBytes,'text/plain')
    * def briefname = get response /GetRecordsResponse/SearchResults/BriefRecord[type = 'dataset']/title
    * print briefname
    * def listnames = karate.mapWithKey(briefname, 'datasetname')
    * def briefarray = get response /GetRecordsResponse/SearchResults/BriefRecord[type = 'dataset']/identifier
    * print briefarray
    * def list =  karate.mapWithKey(briefarray ,'datasetIdentifierCode')
  # * karate.write(briefarray, 'ngrlist.json')

  Scenario Outline: Check dataset record  in ngr voor  <datasetIdentifierCode>


    Given path 'geonetwork/srv/dut/inspire'
    And param service = 'CSW'
    And param version = '2.0.2'
    And param request = 'GetRecordById'
    And param id = '<datasetIdentifierCode>'
    And param elementsetname = 'full'
    And param outputSchema = 'http://www.isotc211.org/2005/gmd'
    When method get
    Then status 200
    * eval karate.embed(responseBytes,'application/xml')
    And match /GetRecordByIdResponse/MD_Metadata/fileIdentifier/CharacterString == '<datasetIdentifierCode>'
    # check INSPIRE TG2 anchor
    # And match /GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/identifier/MD_Identifier/code/Anchor == '<datasetIdentifierCode>'
    * def title =  get response /GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/title/CharacterString
    * print title
    * def organisation =  get response /GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/pointOfContact[*]/CI_ResponsibleParty/organisationName/Anchor
    * print 'organisation:', organisation
    * json xlinks = get response /GetRecordByIdResponse//@href
    * print xlinks
    * call read('def/checkxlinkurl.template.feature') karate.mapWithKey(xlinks ,'link')

    Examples:
      | list |


# csv def/datasetlist.csv has the following field:
#Examples:
#    | datasetIdentifierCode                |
#    | 3703b249-a0eb-484e-ba7a-10e31a55bcec |
