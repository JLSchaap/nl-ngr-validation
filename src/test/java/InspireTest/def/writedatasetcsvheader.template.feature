@ignore
Feature:  write headers dataset.csv service headers

    Scenario: headers

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * eval db.writeln( '"datasetIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",', 'target/surefire-reports/datasets.csv')
        * eval db.writeln( '"serviceIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",', 'target/surefire-reports/services.csv')
