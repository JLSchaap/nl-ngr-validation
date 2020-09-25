@ignore
Feature:  write header dataset.csv

    Scenario: write header dataset.csv

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * def line1 = '"datasetIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",'
        * def line2 = '"serviceIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",'
      
        * eval db.writeln( line1, 'target/surefire-reports/datasets.csv')
        * eval db.writeln( line2, 'target/surefire-reports/services.csv')
