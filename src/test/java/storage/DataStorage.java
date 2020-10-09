package storage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.io.FileUtils;


public class DataStorage {
	private static final String NLTEST = "NLTEST";
	private static final String TARGET_SUREFIRE_REPORTS = "/target/surefire-reports";
	private static final String SRC_TEST_JAVA_INSPIRE_TEST_NGR = "/src/test/java/InspireTest/ngr";
	private static final String userdir = new File(java.lang.System.getProperty("user.dir")).getAbsolutePath();

	public File reportdir() {
		return (new File(userdir + TARGET_SUREFIRE_REPORTS));
	}

	public File outputdir() {
		return (new File(userdir + "/output"));
	}

	String featurename = "T99_featureNotSetYet.feature";

	public DataStorage setfeature(String featurefilename) {
		featurename = featurefilename;
		return this;
	}

	public String writeln(final String str, final String fileName) throws IOException {

		return (writeln(str, fileName, true));
	}

	public String writeln(final String str, final String fileName, boolean append) throws IOException {

		final FileOutputStream fos = new FileOutputStream(fileName, append);
		final String printline = str + System.getProperty("line.separator");
		fos.write(printline.getBytes());
		fos.close();
		return "OK";
	}

	public void writeheaderdataset(final String fileName) throws IOException {

		String header;
		header = "\"datasetIdentifierCode\",\"title\",\"MD_DataIdentificationCitationAnchor\",\"organisation\",\"electronicMailAddress\",\"metadataStandardVersion\"";
		writeheader(header, fileName);

	}

	public void writeheaderservice(final String fileName) throws IOException {
		String header;
		header = "\"serviceIdentifierCode\",\"title\",\"url\",\"protocol\", \"organisation\",\"electronicMailAddress\",\"metadataStandardVersion\",\"operatesOn\",\"datasetIdentifierCode\",\"servicetype\"";
		writeheader(header, fileName);

	}

	public void writeheader(String header, String fileName) throws IOException {
		writeln(header, fileName, false);
	}

	public File outputpath(String step) {
		File outdir = new File(outputdir().getAbsolutePath() + "/" + step);
		return outdir;
	}

	public File outputpath() {
		File outdir = new File(outputdir().getAbsolutePath() + "/" + stepname());
		return outdir;
	}

	public void ensureDirectory(String dirstring) {
		File dir = new File(dirstring);
		ensureDirectory(dir);

	}

	public void cleandir(File dirpath) throws IOException {
		ensureDirectory(dirpath);
		System.out.println("Cleaning: " + dirpath);
		FileUtils.cleanDirectory(dirpath);
	}

	public void ensureDirectory(File dirPath) {
		if (!dirPath.exists()) {
			Boolean created = dirPath.mkdir();
			assert (created);
		}
	}

	public void cleanStepOutputDir(String step) throws IOException {

		cleandir(outputpath(step));
	}

	public String cleanname() {
		return featurename.substring(featurename.indexOf('_') + 1, featurename.lastIndexOf('.'));
	}

	public String stepname() {
		return featurename.substring(0, featurename.lastIndexOf('.'));
	}

	public File startdir() {
		return (new File(userdir + SRC_TEST_JAVA_INSPIRE_TEST_NGR));
	}

	public static String projectname() {
		return NLTEST;
	}

	// --- inspire specific
	public String getdatasetuuid(String str) {
		// "https://geodata.nationaalgeoregister.nl/inspire/su-grid/wms?request=GetCapabilities","OGC:WMS","Beheer
		// PDOK","[beheerPDOK@kadaster.nl, beheerPDOK@kadaster.nl]","Nederlands metadata
		// profiel op ISO 19119 voor services
		// 2.0","http://nationaalgeoregister.nl/geonetwork/srv/dut/csw?service=CSW&version=2.0.2&request=GetRecordById&outputschema=http://www.isotc211.org/2005/gmd&elementsetname=full&id=db8d613f-5edc-4467-9cc0-e2dcfb9d64a8#MD_DataIdentification"
		int end = str.indexOf("#MD_DataIdentification");
		if (end == -1) {
			return (str.substring(str.indexOf("id=") + 3));
		}
		return str.substring(str.indexOf("id=") + 3,end  );

	}

}
