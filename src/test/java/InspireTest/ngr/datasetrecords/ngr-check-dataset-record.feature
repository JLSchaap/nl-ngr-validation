

Feature:  Check dataset record datasetIdentifierCode
  Background:
    * configure readTimeout = 240000
    #* configure connectTimeout = 60000

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
    * def title =  get response //citation/CI_Citation/title/CharacterString
    * print 'title:' + title
    * print title
    #* def organisation =  get response /GetRecordByIdResponse/MD_Metadata/identificationInfo/MD_DataIdentification/pointOfContact[*]/CI_ResponsibleParty/organisationName/Anchor
    #* print 'organisation:', organisation
    * def xlinks = get response /GetRecordByIdResponse//@href
    * def ObjectValues =
      """
      function (obj) {
      var vals = [];
      for (var prop in obj) {
      vals.push(obj[prop]);
      }
      return vals;
      }
      """

    * def filterx =
      """
      function (array1, array2) {
      return array1.filter(function (x) { return array2.indexOf(x) < 0; });
      }
      """
    #* print callonesresult.knownlinks
    #* print xlinks

    # * def alphas1 = ["http://inspire.ec.europa.eu/metadata-codelist/ResourceType", "http://inspire.ec.europa.eu/metadata-codelist/TopicCategory"];
    # * def alphas2 = ["http://inspire.ec.europa.eu/metadata-codelist/ResourceType"];
    # * def x = filterx(ObjectValues(alphas1), ObjectValues(alphas2))

    * def nlinks = filterx(ObjectValues(xlinks), ObjectValues(callonesresult.knownlinks))


    * print nlinks
    * def id = "<datasetIdentifierCode>"


    * call read('def/checkxlinkurl.template.feature') karate.mapWithKey(nlinks ,'link')

    # * karate.write("<datasetIdentifierCode>;"+ title, filename)
    Examples:
      | callonesresult.list |


# csv def/datasetlist.csv has the following field:
#Examples:
# | datasetIdentifierCode                |
# | f273941e-9c3b-43bc-b886-2d50d0bf9348 |
# | 19165027-a13a-4c19-9013-ec1fd191019d |
#| 4bb89277-6ebe-4e66-8929-cd275aa7fd81 |
