@step1
Feature: get details

  Background:
    * url 'http://nationaalgeoregister.nl/'
    * def mystorage = Java.type('storage.DataStorage')
    * def db = new mystorage
    * def db = db.setfeature(karate.info.featureFileName)

    * def separator = java.lang.System.getProperty("file.separator")

    * def idfile = "file:" + db.outputpath("T01_ids").getAbsolutePath() + separator + 'idsDataset.json'
    * def list = karate.read(idfile)
    * def outputpath = db.outputpath()
    * print outputpath
    * eval db.ensureDirectory(outputpath)
    * def outfile = outputpath + separator  + "datasets.csv"
    * eval db.writeheaderdataset(outfile)



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
    * string scopecode = get response //MD_Metadata/hierarchyLevel/MD_ScopeCode/@codeListValue
    * string title =  get response //citation/CI_Citation/title/CharacterString
    * string email = get response //electronicMailAddress/CharacterString
    * string organisationpath1 = karate.get('//MD_Metadata/contact/CI_ResponsibleParty/organisationName/Anchor')
    * string organisationpath2 = karate.get('//MD_Metadata/contact/CI_ResponsibleParty/organisationName/CharacterString')
    * string organisationpath = organisationpath1 ? organisationpath1 : organisationpath2
    * string metadataStandardVersionpath = karate.get ('/GetRecordByIdResponse/MD_Metadata/metadataStandardVersion/CharacterString')
    * string MD_DataIdentificationCitationAnchor = karate.get ('/GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/citation/CI_Citation/identifier//@href')
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + (MD_DataIdentificationCitationAnchor ? MD_DataIdentificationCitationAnchor : 'no MD_DataIdentificationCitationAnchor') + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '"' , outputpath + separator + scopecode + 's.csv')
    * eval db.writeln('"<datasetIdentifierCode>","'+ title + '","' + (MD_DataIdentificationCitationAnchor ? MD_DataIdentificationCitationAnchor : 'no MD_DataIdentificationCitationAnchor') + '","' + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '","'+ email + '","' + (metadataStandardVersionpath ?  metadataStandardVersionpath  : 'no metadatastandard path found') + '"' , outputpath + separator + scopecode + 's-'  + (organisationpath ? organisationpath : 'no organisationName found in dataset record') + '.csv')

    Examples:
      | list |
# csv def/datasetlist.csv has the following field:
# Examples:
#  | datasetIdentifierCode                |
#  | fe2f9091-1962-4073-9e3b-3e4aeed488a5 |
#  | f273941e-9c3b-43bc-b886-2d50d0bf9348 |
#  | 19165027-a13a-4c19-9013-ec1fd191019d |
#  | 19165027-a13a-4c19-9013-ec1fd191019d |
