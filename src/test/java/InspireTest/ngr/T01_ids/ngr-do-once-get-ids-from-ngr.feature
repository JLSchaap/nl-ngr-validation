@step0
Feature:  run onces  automatically get id's form ngr

  
    Scenario: get id's
        * configure readTimeout = 240000
        * url 'http://nationaalgeoregister.nl/'
        * def callonesresult = callonce read('classpath:InspireTest/def/getcswbriefrecords.feature')




