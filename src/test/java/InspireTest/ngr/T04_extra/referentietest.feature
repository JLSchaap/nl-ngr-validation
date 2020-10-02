@step3
Feature: Service test Invasieve exoten

  Background:
    * url 'https://inspire.ec.europa.eu/validator/v2/'


  Scenario Outline: <label> <serviceEndpoint> <testsuite>

    * def testRunRequest =
      """
      {
        "label": "<label>",
        "executableTestSuiteIds": [
          "<testsuite>"
        ],
        "arguments": {},
        "testObject": {
          "resources": {
            "serviceEndpoint": "<serviceEndpoint>"
          }
        }
      }
      """

    Given path 'TestRuns'
    And request testRunRequest
    When method post
    Then assert responseStatus == 200 || responseStatus == 201
    * print response.EtfItemCollection.testRuns.TestRun.id
    * print response.EtfItemCollection.testRuns.TestRun.status
    * print response.EtfItemCollection.testRuns.TestRun.label
    * print response.EtfItemCollection.ref
    * print response.EtfItemCollection.testRuns.TestRun.logPath

    * def statuspath = "TestRuns/" + response.EtfItemCollection.testRuns.TestRun.id
    * def progresspath = "TestRuns/" + response.EtfItemCollection.testRuns.TestRun.id + "/progress"
    * print 'statuspath', statuspath
    * print 'progresspath ', progresspath

    #Given path  statuspath
    #When method HEAD
    # And retry until responseStatus == 204
    #* print response

    Given path  progresspath
    When method GET
    And retry until response.val == response.max
    * print response

    Given path  progresspath
    When method GET

    * print response

    Given path  statuspath
    When method GET

    * print response.EtfItemCollection.testRuns.TestRun.id
    * print response.EtfItemCollection.testRuns.TestRun.status
    * def status = response.EtfItemCollection.testRuns.TestRun.status
    * print status
    * print response.EtfItemCollection.testRuns.TestRun.label
    * print response.EtfItemCollection.ref
    * def ref = response.EtfItemCollection.ref
    * print ref

    * print response.EtfItemCollection.testRuns.TestRun.logPath

    # save response
    *  def embedUrl =
      """ function(url, hyperlinkText)
      { var html = '<a href=\"' + url + '\" >' + hyperlinkText + '</a>';
      karate.embed(html,'text/html'); }
      """

    * def time = java.lang.System.currentTimeMillis()
    * def jsonPath = time + '<label>.json'
    * def responsecontent = response
    * karate.write(responsecontent, jsonPath)
    * def a = embedUrl (ref.substring(0, ref.length - 5) + '.html' ,  status )
    * def a = embedUrl ("../../" + jsonPath ,  status )

    # lets compare content

    * def json = get[0] response.EtfItemCollection.referencedItems.testTaskResults
    * def jsonfailedStep = $json.TestTaskResult.testModuleResults.TestModuleResult[*].testCaseResults.TestCaseResult[*].testStepResults.TestStepResult[?(@.status=='FAILED')]
    * def jsonFailedStepmessages = $jsonfailedStep[*].messages.message.ref
    * print jsonFailedStepmessages
    * def jsonfailedAssert = $jsonfailedStep[*].testAssertionResults.TestAssertionResult[?(@.status=='FAILED')]
    * def jsonfailedMessages = $jsonfailedAssert[*].messages.message
    * def tmpref = $jsonfailedMessages[*].ref
    * def refs = karate.append( jsonFailedStepmessages, tmpref )


    * def expectedresult = <ETFexpected>
    * def Collections = Java.type('java.util.Collections')
    * copy sortedrefs = refs
    * Collections.sort(sortedrefs)
    * copy sortedexpectedrefs = $expectedresult[*].ref
    * Collections.sort(sortedexpectedrefs)
    * print refs
    * print sortedrefs
    * print sortedexpectedrefs
    * match sortedrefs == sortedexpectedrefs

    * print jsonfailedMessages 
    #* match jsonfailedMessages == expectedresult


    * def tempdir = java.lang.System.getProperty('user.dir')
    * def separator = java.lang.System.getProperty("file.separator")
    * def outputpath = tempdir + separator + 'output' + separator
    * def mystorage = Java.type('storage.DataStorage')
    * def db = new mystorage
    * def LocalDateTime = Java.type('java.time.LocalDateTime')
    * eval db.writeln('- Test: '+ karate.info.scenarioName+ '\n  Time: '+ LocalDateTime.now() +'\n  Errors: ' +  sortedrefs  ,  outputpath + karate.info.featureFileName + '.yaml')








    Examples:
      | testsuite                               | label                                                                                                   | serviceEndpoint                                                                          | ETFexpected                                              |
      | EID11571c92-3940-4f42-a6cd-5e2b1c6f4d93 | Conformance Class: Download Service - Pre-defined Atom,  Atom Invasieve Exoten (INSPIRE Geharmoniseerd) | https://geodata.nationaalgeoregister.nl/rvo/inspire/invasieve-exoten/atom/v1_0/index.xml | read('classpath:InspireTest/ETFexpected/atomerror.json') |

#"serviceIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",
#"d2a05dd5-98e8-4f9c-8ba2-7fe2d5c7c507","Spreiding van soorten - Invasieve Exoten (INSPIRE geharmoniseerd) ATOM V1","no MD_DataIdentificationCitationAnchor","Beheer PDOK","[beheerPDOK@kadaster.nl, beheerpdok@kadaster.nl]","Nederlands metadata profiel op ISO 19119 voor services 2.0",
#"b196f948-5d87-4eb4-9854-a93841c3877f","Spreiding van soorten - Invasieve Exoten (INSPIRE geharmoniseerd) WMS V1","no MD_DataIdentificationCitationAnchor","Beheer PDOK","[beheerPDOK@kadaster.nl, beheerPDOK@kadaster.nl]","Nederlands metadata profiel op ISO 19119 voor services 2.0",
