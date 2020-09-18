
Feature: check known dataset records
    Background:
        * configure readTimeout = 240000
        * def knownlinks = karate.jsonPath(karate.read('classpath:InspireTest/ngr/datasetrecords/def/knownlink.csv'), '[*].knownlink')
        #* def callheaderresult = callonce read('def/writedatasetcsvheader.template.feature')
        * def datasetsresult = callonce read('def/getdataset.template.feature')
        * print datasetsresult 
        * csv datasets = datasetsresult.response
        # csv headers are also imported
        * remove datasets $[0]
        * print datasets
        * url 'http://nationaalgeoregister.nl/'


    Scenario Outline: <title>
        <datasetIdentifierCode> <organisation> <electronicMailAddress>
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


      #  * def mystorage = Java.type('storage.DataStorage')
      #  * def db = new mystorage
      #  * eval db.mywriteln('<datasetIdentifierCode>","'+ title + '","' + organisation + '","'+ email +'",' , 'target/surefire-reports/datasets.csv')

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

        * def nlinks = filterx(ObjectValues(xlinks), ObjectValues(knownlinks))


        * print nlinks
        * def id = "<datasetIdentifierCode>"


        * call read('def/checkxlinkurl.template.feature') karate.mapWithKey(nlinks ,'link')
         Examples:
          | datasets |

       # Examples:
       #     | datasetIdentifierCode                | title                                     | organisation                                        | electronicMailAddress                                    |
       #     | 3703b249-a0eb-484e-ba7a-10e31a55bcec | Invasieve Exoten (INSPIRE Geharmoniseerd) | Ministerie van Landbouw, Natuur en Voedselkwaliteit | [geodatabeheer.giscc@rvo.nl, Geodatabeheer.GISCC@rvo.nl] |
#       | 977e0e94-7aa9-4784-b2da-eaec44adb61b | Habitatrichtlijn verspreiding van habitattypen | [Ministerie van Economische Zaken - GIS Competence Center, Wageningen Environmental Research (Alterra), PDOK, Alterra]                        | [geodatabeheer.giscc@rvo.nl, GeoDesk.CGI@wur.nl, geodatabeheer.giscc@rvo.nl, beheerPDOK@kadaster.nl, ] |
#       | fcefa13c-44e2-4953-b6d6-1ddceebc57fc | Vogelrichtlijn verspreiding van soorten        | [Ministerie van Economische Zaken - GIS Competence Center, Wageningen Environmental Research (Alterra), PDOK, Sovon Vogelonderzoek Nederland] | geodatabeheer.giscc@rvo.nl, GeoDesk.CGI@wur.nl, geodatabeheer.giscc@rvo.nl, beheerPDOK@kadaster.nl, ]  |
#       | f99e915a-75e5-4c36-97f2-61eff692d85b | Grondwateronderzoek onder INSPIRE              | TNO Geologische Dienst Nederland, TNO Geologische Dienst Nederland, TNO Geologische Dienst Nederland]                                         | [info@dinoloket.nl, info@dinoloket.nl, info@dinoloket.nl]                                              |
