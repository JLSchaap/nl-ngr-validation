
package InspireTest;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.opencsv.exceptions.CsvDataTypeMismatchException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;


import metadata.DatasetList;
import metadata.Harvest;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.*;
import org.junit.platform.commons.annotation.Testable;
import storage.DataStorage;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@KarateOptions(tags = { "~@ignore" })
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@Testable
class TestAll {
    private static final DataStorage db = new DataStorage();

    @BeforeAll
    public static void oneTimeSetUp() throws IOException {

        // db.cleandir(db.reportdir());
    }

    @AfterAll
    public static void oneTimeTearDown() {
        System.out.println("write report: " + db.reportdir().getAbsolutePath());
        generateReport(db.reportdir().getAbsolutePath());
    }

    @Test
    @Order(1)
    void T01_ids() throws IOException {
        db.cleandir(db.outputdir());
        String step = "T01_Ids";
        db.cleanStepOutputDir(step);
        runtest(step);
    }

    @Test
    @Order(2)
    void T02() throws IOException {
        String step = "T02_Datasets";

        db.cleanStepOutputDir(step);
        runtest(step);

        step = "T02_Services";
        db.cleanStepOutputDir(step);
        runtest(step);
    }

    @Test
    @Order(3)
    void T03loadAndEvaluateh() throws IOException, CsvDataTypeMismatchException, CsvRequiredFieldEmptyException {

        String step = "T03_harvestEval";
        db.cleanStepOutputDir(step);
        loadtestdata();

        File outfile3 = DatasetList.INSTANCE.getInstance()
                .writecsv(db.outputdir() + "/" + step + "/datasetsmetservices.csv");
        System.out.println(outfile3.getAbsolutePath());
        File outfile4 = DatasetList.INSTANCE.getInstance().writeResultsCSV(db.outputdir() + "/" + step + "/datasetsmetserviceserror.csv");
        System.out.println(outfile4.getAbsolutePath());

        Harvest harvest = new Harvest(db.harvestfile());
        File outfile5 = new File(db.outputdir().getAbsolutePath() + "/" + step + "/INSPIREGeoportalHarvestExtra.csv");
        System.out.println(outfile5);
        File outfile6 = new File(
                db.outputdir().getAbsolutePath() + "/" + step + "/INSPIREGeoportalHarvestExtraError.csv");
        System.out.println(outfile6);
        harvest.writeharvest(outfile5.getAbsolutePath(), outfile6.getAbsolutePath());
        assertTrue(outfile5.exists());
        assertTrue(outfile6.exists());
    }
/*
    @Test
    @Order(4)
    void T04Createtests() throws IOException {

        String step = "T04_tests";
        db.cleanStepOutputDir(step);
        loadtestdata();

        Templatedir templatepath = new Templatedir();
        File temp = new File (db.startdirtop() + File.separator +"karatetemplate"); 
        System.out.println("templatedir:"+ temp.getAbsolutePath());
        templatepath.builder(temp, ".feature");
        File outdir = new File(            db.outputdir().getAbsolutePath() + "/" + step );
        System.out.println("outdir:"+outdir.getAbsolutePath());
        DatasetList.INSTANCE.getInstance().createdirstructure(outdir, templatepath,true);
        assertTrue(outdir.exists());
  
    }
*/
    private void loadtestdata() throws FileNotFoundException {
        File file = new File(db.outputpath("T02_Datasets") + "/datasets.csv");
        System.out.println(file.getAbsolutePath());
        DatasetList.INSTANCE.getInstance().loadDataset(file.getAbsolutePath(), true);
        File servicefile = new File(db.outputpath("T02_Services") + "/services.csv");
        System.out.println(servicefile.getAbsolutePath());
        DatasetList.INSTANCE.getInstance().loadService(servicefile.getAbsolutePath());
    }


    void runtestdir(String step) throws IOException {
        File stepdir = new File(db.startdir().getAbsolutePath() + "/" + step);

        File stepreportdir = new File(db.reportdir().getAbsolutePath() + "/" + step);

        System.out.println("start " + step + " parallel:" + stepdir.getAbsolutePath());
        final Results results = Runner.parallel(stepreportdir.getAbsolutePath(), 4, stepdir.getAbsolutePath());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    void runtest(String step) {
        File featurefile = new File(db.startdir().getAbsolutePath() + "/" + step + ".feature");
        System.out.println("start " + step + " single paralell run :" + featurefile.getAbsolutePath());
        List<String> tags = List.of("~@ignore");
        List<String> paths = List.of(featurefile.getAbsolutePath());
        final Results results = Runner.parallel(tags, paths, 1, db.reportdir().getAbsolutePath());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());

    }

    private static void generateReport(final String karateOutputPath) {
        final Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" },
                true);
        final List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        final Configuration config = new Configuration(new File(karateOutputPath), DataStorage.projectname());
        final ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}
