

Feature:  Check dataset record datasetIdentifierCode
  Background:
    * configure readTimeout = 240000
    * configure connectTimeout = 60000

    * url 'http://nationaalgeoregister.nl/'

    * def callonesresult = callonce read('def/getcswbriefrecords.feature')
    * print callonesresult

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
    #* def organisation =  get response /GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/pointOfContact[*]/CI_ResponsibleParty/organisationName/Anchor
    #* print 'organisation:', organisation
    * json xlinks = get response /GetRecordByIdResponse//@href
    * eval karate.embed(  xlinks,'text/plain')
    * call read('def/checkxlinkurl.template.feature') karate.mapWithKey(xlinks ,'link')

    Examples:
      | callonesresult.list |


# csv def/datasetlist.csv has the following field:
# Examples:
#   | datasetIdentifierCode                |
#   | f273941e-9c3b-43bc-b886-2d50d0bf9348 |
# | 19165027-a13a-4c19-9013-ec1fd191019d |
