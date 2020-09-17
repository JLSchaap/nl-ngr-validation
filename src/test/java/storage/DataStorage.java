package storage;

import java.io.FileOutputStream;
import java.io.IOException;


public class DataStorage {

    public String mywriteln(final String str, final String fileName) throws IOException {

        final FileOutputStream fos = new FileOutputStream(fileName, true);
        fos.write(str.getBytes());
        fos.write(System.getProperty("line.separator").getBytes());
        fos.close();
        return "OK";
    }

    public String writefilen(final String str, final String fileName) throws IOException {

        final FileOutputStream fos = new FileOutputStream(fileName, true);
        fos.write(str.getBytes());
        fos.write(System.getProperty("line.separator").getBytes());
        fos.close();
        return "OK";
    }

}
