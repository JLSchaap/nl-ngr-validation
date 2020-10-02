@step1
Feature:  get details
  Background:

    * url 'http://nationaalgeoregister.nl/'
    * def tempdir = java.lang.System.getProperty('user.dir')
    * def separator = java.lang.System.getProperty("file.separator")
    * def outputpath = tempdir + separator + 'output' + separator + "T02_services" + separator

    * def idfile = outputpath + 'idsService.json'
    * print idfile
    * def list =  karate.read( idfile)
    * def callheaderresult = callonce read('classpath:InspireTest/def/writedatasetcsvheader.template.feature')


  Scenario Outline: <datasetIdentifierCode>

    Given path 'geonetwork/srv/dut/inspire'
    And param service = 'CSW'
    And param version = '2.0.2'
    And param request = 'GetRecordById'
    And param id = '<datasetIdentifierCode>'
    And param elementsetname = 'full'
    And param outputSchema = 'http://www.isotc211.org/2005/gmd'
    When method get
    Then status 200
    And match /GetRecordByIdResponse/MD_Metadata/fileIdentifier/CharacterString == '<datasetIdentifierCode>'

    * def scopecode = get response //MD_Metadata/hierarchyLevel/MD_ScopeCode/@codeListValue
    * def title =  get response //citation/CI_Citation/title/CharacterString
    * def email = get response //electronicMailAddress/CharacterString
    * def organisationpath = karate.get('//MD_Metadata/contact/CI_ResponsibleParty/organisationName/CharacterString')
    * def metadataStandardVersionpath = karate.get ('/GetRecordByIdResponse/MD_Metadata/metadataStandardVersion/CharacterString')
    * def MD_DataIdentificationCitationAnchor = karate.get ('/GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/identifier//@href')
    #  * def connectUrl = karate.get ( '//MD_DigitalTransferOptions/onLine[*]/CI_OnlineResource/linkage/URL')
    * def connectUrl = karate.get ('/GetRecordByIdResponse/MD_Metadata/distributionInfo/MD_Distribution/transferOptions/MD_DigitalTransferOptions/onLine/CI_OnlineResource/linkage/URL')
    * def protocol = karate.get ( '/GetRecordByIdResponse/MD_Metadata/distributionInfo/MD_Distribution/transferOptions/MD_DigitalTransferOptions/onLine/CI_OnlineResource/protocol/CharacterString')
    #unique values
    #* def connectUrl = new java.util.HashSet(connectUrlAll)
    * def mystorage = Java.type('storage.DataStorage')
    * def db = new mystorage
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '",' , outputpath + scopecode + 's.csv')
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '",' , outputpath + scopecode + 's-' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')
   # * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '",' , outputpath + scopecode + 's-'  + "-" + protocol + "-"  +  (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')

    Examples:
      | list |


# csv def/datasetlist.csv has the following field:
#  Examples:
#    | datasetIdentifierCode                |
#    | fe2f9091-1962-4073-9e3b-3e4aeed488a5 |
#    | f273941e-9c3b-43bc-b886-2d50d0bf9348 |
#    | 19165027-a13a-4c19-9013-ec1fd191019d |
#    | 4bb89277-6ebe-4e66-8929-cd275aa7fd81 |
