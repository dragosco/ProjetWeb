package outils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 *
 * @author Dragos
 */
public class InputStreamToByteArray {
    
    private final InputStream is;
    
    public InputStreamToByteArray(InputStream is) {
        this.is = is;
    }
    
    public byte[] getBytes() throws IOException {
        
        int len;
        int size = 1024*16;
        byte[] buffer;

        if (is instanceof ByteArrayInputStream) {
            size = is.available();
            buffer = new byte[size];
            len = is.read(buffer, 0, size);
        } else {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            buffer = new byte[size];
          while ((len = is.read(buffer, 0, size)) != -1)
            bos.write(buffer, 0, len);
            buffer = bos.toByteArray();
        }
        return buffer;
    }
}
