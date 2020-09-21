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
        * print "testing xlinkurl:" + link

        Given url link
        When method HEAD
      
        # * print "last modified",  responseHeaders['Last-Modified'][0]
        # * print "content type",  responseHeaders['Content-Type'][0]

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * eval db.mywriteln('"'+ link + '","'+ title + '","' + responseStatus + '",'  , 'target/surefire-reports/foundlink.csv')
        * match responseStatus ==  200
        * match responseHeaders['Content-Type'][0] == '#string'
