@ignore
Feature:  write headers dataset.csv service headers

    Scenario: headers

        * def mystorage = Java.type('storage.DataStorage')
        * def db = new mystorage
        * def tempdir = java.lang.System.getProperty('user.dir')
        * def separator = java.lang.System.getProperty("file.separator")
        * def outputpath = tempdir + separator + 'output' + separator
        * eval db.writeln( '"datasetIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",', outputpath + 'datasets.csv')
        * eval db.writeln( '"serviceIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",', outputpath + 'services.csv')
        * eval db.writeln( '"serviceIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",', outputpath + 'seriess.csv')
        * eval db.writeln( '"serviceIdentifierCode","title","dataIdentificationCitationAnchor","organisation","electronicMailAddress","metadataStandardVersion",', outputpath + 'services-Beheer PDOK.csv')
