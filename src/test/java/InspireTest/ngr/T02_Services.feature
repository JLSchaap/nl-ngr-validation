@step1
Feature:  get details
  Background:

    * url 'http://nationaalgeoregister.nl/'
    * def mystorage = Java.type('storage.DataStorage')
    * def db = new mystorage
    * def db = db.setfeature(karate.info.featureFileName)
    * def separator = java.lang.System.getProperty("file.separator")
    * def outputpath = db.outputpath()
    * eval db.ensureDirectory(outputpath)
    * eval db.writeheaderservice(outputpath + separator  + "services.csv" )
    * eval db.writeheaderservice(outputpath + separator  + "services-Beheer PDOK.csv" )

    * def idfile = db.outputpath("T01_ids") + separator + 'idsService.json'


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

    * def operateson = get response //MD_Metadata/identificationInfo/SV_ServiceIdentification/operatesOn/@href
    * print organisationpath
    * print operateson

    * def servicetype = get response //MD_Metadata/identificationInfo/SV_ServiceIdentification/serviceType/LocalName
        #unique values
    #* def connectUrl = new java.util.HashSet(connectUrlAll)
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '","' + operateson + '","' + db.getdatasetuuid(operateson) + '","' + servicetype + '"', db.outputpath() + separator + scopecode + 's.csv')
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '","' + operateson + '","' + db.getdatasetuuid(operateson) + '","' + servicetype + '"', db.outputpath() + separator + scopecode + 's-' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')
    # * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '",' , outputpath + scopecode + 's-'  + "-" + protocol + "-"  +  (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')
    @data=all
    Examples:
      | karate.read( idfile) |

    # csv def/datasetlist.csv has the following field:
    @data=test
    Examples:
      | datasetIdentifierCode                |
      | dd49e02c-ea87-4ffc-89dd-f888608d95b7 |
