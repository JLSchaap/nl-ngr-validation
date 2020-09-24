

Feature:  Check title organisation and email in dataset records
  Background:
    * configure readTimeout = 240000
    #* configure connectTimeout = 60000

    * url 'http://nationaalgeoregister.nl/'

    * def callonesresult = callonce read('def/getcswbriefrecords.feature')
    * configure connectTimeout = 30000
    * print callonesresult

  Scenario Outline: Check dataset <datasetIdentifierCode>
    Check metadata record van <datasetIdentifierCode>

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
    * def title =  get response //citation/CI_Citation/title/CharacterString
    * print 'title:' + title
    * print title
    * def email = get response //electronicMailAddress/CharacterString
    * print email

    * def organisationpath = karate.get('//organisationName/CharacterString')
    * def organisation =  organisationpath ? organisationpath : 'no organisationName found in dataset record'

    * print 'organisation:', organisation
    #* def MD_DataIdentificationCitationAnchor = karate.get ('/GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/identifier/MD_Identifier/code/Anchor')
    * def MD_DataIdentificationCitationAnchor = karate.get ('/GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/identifier')
    * def dataIdentificationCitationAnchor = MD_DataIdentificationCitationAnchor ? MD_DataIdentificationCitationAnchor : 'no MD_DataIdentificationCitationAnchor'
    * def mystorage = Java.type('storage.DataStorage')
    * def db = new mystorage
    * eval db.mywriteln('"<datasetIdentifierCode>","'+ title + '","' + dataIdentificationCitationAnchor + '","' + organisation + '","'+ email +'",' , 'target/surefire-reports/datasets.csv')



    #* call read('def/checkxlinkurl.template.feature') karate.mapWithKey(nlinks ,'link')

    # * karate.write("<datasetIdentifierCode>;"+ title, filename)
    Examples:
      | callonesresult.list |


# csv def/datasetlist.csv has the following field:
#  Examples:
#    | datasetIdentifierCode                |
#    | f273941e-9c3b-43bc-b886-2d50d0bf9348 |
#    | 19165027-a13a-4c19-9013-ec1fd191019d |
#    | 4bb89277-6ebe-4e66-8929-cd275aa7fd81 |
