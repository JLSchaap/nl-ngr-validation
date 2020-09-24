@ignore
Feature:  template feature checking link __arg
    #  - do not run as individual feature
    #
    # usage
    #  * def result = call read('def/checkdownloadurl.template.feature') karate.mapWithKey(myarray ,'link')
    #
    Scenario: __arg.link

    Background:
        * print "testing xlinkurl:" + link
        # use default values https://intuit.github.io/karate/#default-values for optional parameters:
        * def organisation = karate.get('organisation', '*')
        * def title = karate.get('title', '*')

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * eval db.writeln('"'+ link + '","'+ title + '","' +  organisation + '","try",' , 'target/surefire-reports/trylink.csv')
    
        Given url link
        When method HEAD

        # * print "last modified",  responseHeaders['Last-Modified'][0]
        # * print "content type",  responseHeaders['Content-Type'][0]

      
        * eval db.writeln('"'+ link + '","'+ title + '","' +  organisation + '","' +  responseStatus + '",' , 'target/surefire-reports/foundlink.csv')
        * match responseStatus ==  200
        * match responseHeaders['Content-Type'][0] == '#string'
