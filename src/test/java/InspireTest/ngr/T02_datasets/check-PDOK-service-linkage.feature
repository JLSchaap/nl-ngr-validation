@step2
Feature: check linkage in PDOK service records
    Check xlinks in metadata with a list of identifiable collections of data

    Background:
        * configure readTimeout = 5000

        # to improve performance use al list of known already check links (in check-known-links.feature)
        * def knownlinks = karate.jsonPath(karate.read('classpath:InspireTest/def/knownlink.csv') , '[*].knownlink')



        # get the list of service records

        * def tempdir = java.lang.System.getProperty('user.dir')
        * def separator = java.lang.System.getProperty("file.separator")
        * def outputpath = tempdir + separator + 'output' + separator


     
        * def pdokservices =  karate.read( outputpath + 'services-Beheer PDOK.csv')


        * url 'http://nationaalgeoregister.nl/'


    Scenario Outline: <title> <serviceIdentifierCode>
        <url> <organisation> <electronicMailAddress>
        Given path 'geonetwork/srv/dut/inspire'
        And param service = 'CSW'
        And param version = '2.0.2'
        And param request = 'GetRecordById'
        And param id = '<serviceIdentifierCode>'
        And param elementsetname = 'full'
        And param outputSchema = 'http://www.isotc211.org/2005/gmd'
        When method get
        Then status 200
        * eval karate.embed(responseBytes,'application/xml')
         * def title =  get response //citation/CI_Citation/title/CharacterString
          
        * match title ==  '<title>' 

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
        
        * def id = "<serviceIdentifierCode>"
      #  * call read('classpath:InspireTest/def/checkxlinkurl.template.feature') karate.mapWithKey(nlinks ,'link')
        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
       # * eval db.writeln('"<serviceIdentifierCode>","'+ title + '","' + organisation + '","'+ email +'",' , 'target/surefire-reports/datasetsOkay.csv')

        Examples:
            | pdokservices  |

