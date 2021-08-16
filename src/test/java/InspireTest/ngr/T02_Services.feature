@step1
Feature:  get details
  Background:

    * url 'http://nationaalgeoregister.nl/'
    * def mystorage = Java.type('storage.DataStorage')
    * def db = new mystorage
    * def db = db.setfeature(karate.info.featureFileName)
    * def separator = java.lang.System.getProperty("file.separator")
    * def idfile = "file:" + db.outputpath("T01_ids").getAbsolutePath() + separator + 'idsService.json'
    * def list = karate.read(idfile)
    * def outputpath = db.outputpath()
    * eval db.ensureDirectory(outputpath)
    * eval db.writeheaderservice(outputpath + separator  + "services.csv" )
    * eval db.writeheaderservice(outputpath + separator  + "services-Beheer PDOK.csv" )

 


  Scenario Outline: <datasetIdentifierCode>

    Given url 'http://nationaalgeoregister.nl/geonetwork/srv/dut/inspire'
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
    * def organisationpath1 = karate.get('//MD_Metadata/contact/CI_ResponsibleParty/organisationName/Anchor')
    * def organisationpath2 = karate.get('//MD_Metadata/contact/CI_ResponsibleParty/organisationName/CharacterString')
    * def organisationpath = organisationpath1 ? organisationpath1 : organisationpath2
    * def metadataStandardVersionpath = karate.get ('/GetRecordByIdResponse/MD_Metadata/metadataStandardVersion/CharacterString')
    * def MD_DataIdentificationCitationAnchor = karate.get ('/GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/identifier//@href')
    #  * def connectUrl = karate.get ( '//MD_DigitalTransferOptions/onLine[*]/CI_OnlineResource/linkage/URL')

    * string connectrawUrl = karate.get ('/GetRecordByIdResponse/MD_Metadata/distributionInfo/MD_Distribution/transferOptions/MD_DigitalTransferOptions/onLine/CI_OnlineResource/linkage/URL')
    * string connectUrl = db.getCorrectedUrl(connectrawUrl)
    * print connectUrl


  
    * string protocol1 = karate.get  ( '/GetRecordByIdResponse/MD_Metadata/distributionInfo/MD_Distribution/transferOptions/MD_DigitalTransferOptions/onLine/CI_OnlineResource/protocol/Anchor')
    * print protocol1 
    * string protocol2 = karate.get  ( '/GetRecordByIdResponse/MD_Metadata/distributionInfo/MD_Distribution/transferOptions/MD_DigitalTransferOptions/onLine/CI_OnlineResource/protocol/CharacterString')
    * print protocol2
    * string protocol = protocol1 ? protocol1 : protocol2                                               
    * print protocol
    * string operateson = get response //MD_Metadata/identificationInfo/SV_ServiceIdentification/operatesOn/@href
    * print organisationpath
    * print operateson

    * string servicetype = get response //MD_Metadata/identificationInfo/SV_ServiceIdentification/serviceType/LocalName
    #unique values
    #* def connectUrl = new java.util.HashSet(connectUrlAll)
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '","' + operateson + '","' + db.getdatasetuuid(operateson) + '","' + servicetype + '"', db.outputpath() + separator + scopecode + 's.csv')
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '","' + operateson + '","' + db.getdatasetuuid(operateson) + '","' + servicetype + '"', db.outputpath() + separator + scopecode + 's-' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')
    # * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + connectUrl + '","' + protocol + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '",' , outputpath + scopecode + 's-'  + "-" + protocol + "-"  +  (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')
    #  @data=all
    Examples:
     | list |

    # csv def/datasetlist.csv has the following field:
    #   @data=test
   # Examples:
    #  | datasetIdentifierCode                |
    #  | f0c6fbfe-a172-4223-8af3-58f6a28c881d |
    #  | ff9315c8-f25a-4d01-9245-5cf058314ebf |
    #  | b196f948-5d87-4eb4-9854-a93841c3877f |
    #  | 275b64ab-34c2-41f8-8904-97812c7f716e | 
    #  | e222648d-d19e-4a99-a67d-2af1c9aabd75 | 
    #  | 3373be8c-8539-4763-bc22-eba23ac1898f | 
