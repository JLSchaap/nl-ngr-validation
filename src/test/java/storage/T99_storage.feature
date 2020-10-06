
Feature: storage
    Background: Background name
        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * def db = db.setfeature(karate.info.featureFileName)

    Scenario: stepoutname


        Get proper name for output file

        * def stepoutname = db.cleanname()
        * print "stepoutname: " + stepoutname
        * match stepoutname == "storage"

    Scenario: output path

        * def output = db.outputpath()
        * print "outputpath" + output
        * def separator = java.lang.System.getProperty("file.separator")
        * def outdir = db.outputdir() + separator + "T99_storage"
        * print "expected: " + outdir
        * match outdir == output

   Scenario: get uuid from dataseturl csw 
    * def urlstr = 'https://geodata.nationaalgeoregister.nl/inspire/su-grid/wms?request=GetCapabilities","OGC:WMS","Beheer PDOK","[beheerPDOK@kadaster.nl, beheerPDOK@kadaster.nl]","Nederlands metadata profiel op ISO 19119 voor services 2.0","http://nationaalgeoregister.nl/geonetwork/srv/dut/csw?service=CSW&version=2.0.2&request=GetRecordById&outputschema=http://www.isotc211.org/2005/gmd&elementsetname=full&id=db8d613f-5edc-4467-9cc0-e2dcfb9d64a8#MD_DataIdentification'
    * def datasetid = db.getdatasetuuid(urlstr)
    * match datasetid == "db8d613f-5edc-4467-9cc0-e2dcfb9d64a8"