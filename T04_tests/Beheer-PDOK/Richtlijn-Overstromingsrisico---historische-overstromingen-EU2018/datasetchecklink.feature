Feature:  check url

    Scenario: check service url

    Background:
        * print "testing xlinkurl:" + link
          Given url link
        When method HEAD
