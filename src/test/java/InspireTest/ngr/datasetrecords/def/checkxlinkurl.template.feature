@ignore
Feature:  template feature checking link __arg
    #  - do not run as individual feature
    #
    # usage
    #  * def result = call read('def/checkdownloadurl.template.feature') karate.mapWithKey(myarray ,'link')
    #
    Scenario: 
        * def link = __arg.link
        * print "testing xlinkurl:" + link

        Given url link
        When method HEAD
        Then status 200
        And match responseHeaders['Content-Type'][0] == '#string'
        * print "last modified",  responseHeaders['Last-Modified'][0]
        * print "content type",  responseHeaders['Content-Type'][0]
