package storage;

import java.io.FileOutputStream;
import java.io.IOException;



public class DataStorage {
    boolean append = true; 

    public  DataStorage setOverwrite()
    {
        append = false; 
        return this; 
    }
    public String writeln(final String str, final String fileName) throws IOException {

        final FileOutputStream fos = new FileOutputStream(fileName, append);
        final String printline = str + System.getProperty("line.separator");
        fos.write(printline.getBytes()) ;
        fos.close();
        return "OK";
    }

   
}
