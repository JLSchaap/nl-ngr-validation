
package InspireTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.platform.commons.annotation.Testable;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import storage.DataStorage;

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

	/*
	@Test
	@Order(3)
	void T03() throws IOException {
		String step = "T03_Extra";
		db.cleanStepOutputDir(step);
		runtestdir(step); 
		
	}

*/ 

	void runtestdir(String step) throws IOException {
		File stepdir = new File(db.startdir().getAbsolutePath() +"/" + step);

		File stepreportdir = new File(db.reportdir().getAbsolutePath() + "/" + step);

		System.out.println("start " + step + " parallel:" + stepdir.getAbsolutePath());
		final Results results = Runner.parallel(stepreportdir.getAbsolutePath(), 24, stepdir.getAbsolutePath());
		assertEquals(0, results.getFailCount(), results.getErrorMessages());
	}

	void runtest(String step) {
		File featurefile = new File(db.startdir().getAbsolutePath() + "/" + step + ".feature");
		System.out.println("start " + step + " single paralell run :" + featurefile.getAbsolutePath());
		List<String> tags = List.of("~@ignore" );
		List<String> paths = List.of(featurefile.getAbsolutePath());
		final Results results = Runner.parallel(tags, paths, 24, db.reportdir().getAbsolutePath());
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
