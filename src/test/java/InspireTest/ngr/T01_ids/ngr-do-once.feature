@step0
Feature:  run onces  automatically

    Scenario: write header
        * def callheaderresult = callonce read('classpath:InspireTest/def/writedatasetcsvheader.template.feature')

    Scenario: get id's
        * configure readTimeout = 240000
        * url 'http://nationaalgeoregister.nl/'
        * def callonesresult = callonce read('classpath:InspireTest/def/getcswbriefrecords.feature')




