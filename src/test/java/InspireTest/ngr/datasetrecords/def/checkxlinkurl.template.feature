@ignore
Feature:  template feature checking link __arg
    #  - do not run as individual feature
    #
    # usage
    #  * def result = call read('def/checkdownloadurl.template.feature') karate.mapWithKey(myarray ,'link')
    #
    Scenario: __arg.link
        * print "testing xlinkurl:
        * def link = __arg.link
        * print "testing xlinkurl:" + link + "info:" + karate.info

        Given url link
        When method HEAD
        Then status 200
        And match responseHeaders['Content-Type'][0] == '#string'
       # * print "last modified",  responseHeaders['Last-Modified'][0]
       # * print "content type",  responseHeaders['Content-Type'][0]

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * eval db.mywriteln('"'+ link + '"', 'target/surefire-reports/foundlink.csv')

