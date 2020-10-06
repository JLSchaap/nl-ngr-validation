@step0
Feature:  run onces  get id's form ngr

Feature:  getlist of ngr records

    Scenario: getbrief list

        * url 'http://nationaalgeoregister.nl/'
        * configure readTimeout = 240000
        Given path 'geonetwork/srv/dut/inspire'
        And param service = 'CSW'
        And param version = '2.0.2'
        And param request = 'GetRecords'
        And param propertyName = 'identifier'
        And param typeNames = 'csw:Record'
        And param elementsetname = "brief"
        And param resultType = 'results'
        And param startposition = 1
        And param maxRecords = 10
        When method get
        Then status 200
        * eval karate.embed(responseBytes,'application/xml')

        * def tempdir = java.lang.System.getProperty('user.dir')
        * def separator = java.lang.System.getProperty("file.separator")
        * def outputpath = tempdir + separator + 'output' + separator + "T01_ids" + separator
        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * eval db.setOverwrite()

        #all id's
        * def briefarray = get response /GetRecordsResponse/SearchResults/BriefRecord[*]/identifier
        * def list = karate.mapWithKey(briefarray ,'datasetIdentifierCode')
        * eval db.writeln(karate.pretty(list),outputpath + 'ids.json')

        #services
        * def servicearray = get response /GetRecordsResponse/SearchResults/BriefRecord[type='service']/identifier
        * def servicelist = karate.mapWithKey(servicearray,'datasetIdentifierCode')
        * eval db.writeln(karate.pretty(servicelist),outputpath + 'idsService.json')

        #datasets
        * def datasetarray = get response /GetRecordsResponse/SearchResults/BriefRecord[type='dataset']/identifier
        * def datasetlist = karate.mapWithKey(datasetarray,'datasetIdentifierCode')
        * eval db.writeln(karate.pretty(datasetlist ),outputpath + 'idsDataset.json')

#serie pm
# * def seriesarray = get response /GetRecordsResponse/SearchResults/BriefRecord[type='series']/identifier
# * def serieslist = karate.mapWithKey(seriesarray,'datasetIdentifierCode')
# * eval db.writeln(karate.pretty(serieslist),outputpath + 'idsSeries.json')

