
Feature:  write header dataset.csv

    Scenario: write header dataset.csv

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * def line = '"datasetIdentifierCode","title","organisationName","email",'
        * print line
        * eval db.mywriteln( line, 'target/surefire-reports/datasets.csv')
