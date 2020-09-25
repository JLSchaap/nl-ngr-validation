@ignore
Feature:  write header dataset.csv

    Scenario: write header dataset.csv

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * def line = '"datasetIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",'
        * print line
        * eval db.writeln( line, 'target/surefire-reports/datasets.csv')
        * eval db.writeln( line, 'target/surefire-reports/services.csv')
