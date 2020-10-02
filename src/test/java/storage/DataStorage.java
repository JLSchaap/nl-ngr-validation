package storage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

public class DataStorage {
	private static final String NLTEST = "NLTEST";
	private static final String TARGET_SUREFIRE_REPORTS = "/target/surefire-reports";
	private static final String SRC_TEST_JAVA_INSPIRE_TEST_NGR = "/src/test/java/InspireTest/ngr";
	private static final String userdir = java.lang.System.getProperty("user.dir");

	public File reportdir() {
		return (new File(userdir + TARGET_SUREFIRE_REPORTS));
	}

	public File outputdir() {
		return (new File(userdir + "/output"));
	}

	boolean append = true;

	public DataStorage setOverwrite() {
		append = false;
		return this;
	}

	public String writeln(final String str, final String fileName) throws IOException {

		final FileOutputStream fos = new FileOutputStream(fileName, append);
		final String printline = str + System.getProperty("line.separator");
		fos.write(printline.getBytes());
		fos.close();
		return "OK";
	}

	public File outputpath(String step) {
		File outdir = new File(outputdir().getAbsolutePath() + "/" + step);
		return outdir;
	}

	public void cleandir(File dirpath) throws IOException {
		ensureDirectory(dirpath);
		System.out.println("Cleaning: " + dirpath);
		FileUtils.cleanDirectory(dirpath);
	}

	public void ensureDirectory(File dirPath) {
		if (!dirPath.exists()) {
			dirPath.mkdir();
		}
	}

	public void cleanStepOutputDir(String step) throws IOException {

		cleandir(outputpath(step));
	}

	
	public String removefileExtension(String featurename) {
		return featurename.substring(0, featurename.lastIndexOf('.'));
	}
	public File  startdir() {
		return (new File (userdir + SRC_TEST_JAVA_INSPIRE_TEST_NGR));
	}
	public static String projectname() {
		return NLTEST;
	}
}
