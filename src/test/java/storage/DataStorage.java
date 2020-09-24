package storage;

import java.io.FileOutputStream;
import java.io.IOException;


public class DataStorage {

    public String writeln(final String str, final String fileName) throws IOException {

        final FileOutputStream fos = new FileOutputStream(fileName, true);
        final String printline = str + System.getProperty("line.separator");
        fos.write(printline.getBytes()) ;
        fos.close();
        return "OK";
    }

   
}
