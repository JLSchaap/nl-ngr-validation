
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

        * string output = db.outputpath()
        * print "outputpath" + output
        * def separator = java.lang.System.getProperty("file.separator")
        * def outdir = db.outputdir() + separator + "T99_storage"
        * print "expected: " + outdir
        * match outdir == output

    Scenario Outline:  get uuid from dataseturl csw
        * def urlstr = '<url>'
        * def datasetid = db.getdatasetuuid(urlstr)
        * match datasetid == "<uuid>"

        Examples:
            | url                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | uuid                                                                      |
            | http://nationaalgeoregister.nl/geonetwork/srv/en/csw?service=CSW&version=2.0.2&request=GetRecordById&outputSchema=http://www.isotc211.org/2005/gmd&elementSetName=full&id=4961d305-fbb5-426a-9ba3-53e1ca5f3b18                                                                                                                                                                                                                                                                 | 4961d305-fbb5-426a-9ba3-53e1ca5f3b18                                      |
            | https://nationaalgeoregister.nl/geonetwork/srv/dut/csw?SERVICE=CSW&version=2.0.2&REQUEST=GetRecordById&ID=3703b249-a0eb-484e-ba7a-10e31a55bcec&OUTPUTSCHEMA=http://www.isotc211.org/2005/gmd&ELEMENTSETNAME=full#MD_DataIdentification                                                                                                                                                                                                                                         | 3703b249-a0eb-484e-ba7a-10e31a55bcec                                      |  |  |
            | https://geodata.nationaalgeoregister.nl/inspire/su-grid/wms?request=GetCapabilities","OGC:WMS","Beheer PDOK","[beheerPDOK@kadaster.nl, beheerPDOK@kadaster.nl]","Nederlands metadata profiel op ISO 19119 voor services 2.0","http://nationaalgeoregister.nl/geonetwork/srv/dut/csw?service=CSW&version=2.0.2&request=GetRecordById&outputschema=http://www.isotc211.org/2005/gmd&elementsetname=full&id=db8d613f-5edc-4467-9cc0-e2dcfb9d64a8#MD_DataIdentification            | db8d613f-5edc-4467-9cc0-e2dcfb9d64a8                                      |
            | [http://nationaalgeoregister.nl/geonetwork/srv/dut/csw?service=CSW&version=2.0.2&request=GetRecordById&outputschema=http://www.isotc211.org/2005/gmd&elementsetname=full&id=00d8c7c8-98ff-4b06-8f53-b44216e6e75c#MD_DataIdentification, http://nationaalgeoregister.nl/geonetwork/srv/dut/csw?service=CSW&version=2.0.2&request=GetRecordById&outputschema=http://www.isotc211.org/2005/gmd&elementsetname=full&id=701d4eb8-8aae-4708-bba5-3edf6987676d#MD_DataIdentification] | 00d8c7c8-98ff-4b06-8f53-b44216e6e75c 701d4eb8-8aae-4708-bba5-3edf6987676d |

    Scenario Outline: get first url


        * def urlstr = '<urlin>'
        * def newurl = db.getCorrectedUrl(urlstr)
        * match newurl == '<urlout>'

        Examples:
            | urlin                                                | urlout         |
            | ["https://eenwms","https://eenwms","https://eenwms"] | https://eenwms |
            | https://eenwms                                       | https://eenwms |

