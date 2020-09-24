@ignore
Feature:  write header dataset.csv

    Scenario: write header dataset.csv

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * def line = '"datasetIdentifierCode","title","organisation","electronicMailAddress",'
        * print line
        * eval db.writeln( line, 'target/surefire-reports/datasets.csv')
