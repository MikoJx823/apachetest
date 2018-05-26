package com.project.util.barcode;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Hashtable;
import java.util.Map;


import javax.imageio.ImageIO;


import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.ReaderException;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;

/**
 * QRCode
 * 
 */
public class B2cQRCode {
    private static final int BLACK = 0xff000000;
    private static final int WHITE = 0xFFFFFFFF;

    /**
     * @param args
     */
    public static void main(String[] args) {
   	 
   	 B2cQRCode test = new B2cQRCode();
        File file = new File("C://test.png");
        test.encode("https://www.paydollar.com/b2c2/eng/payment/payForm.jsp?c=hoskt4BiJkK2yGEeRWxKWwEpb%2BR1QS1Y", file, BarcodeFormat.QR_CODE, 150, 150, null);
        test.decode(file);
    }
    

    public void encode(String contents, File file, BarcodeFormat format, int width, int height, Map<EncodeHintType, ?> hints) {
        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(contents, format, width, height);
            writeToFile(bitMatrix, "png", file);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void encode(String contents, OutputStream os, BarcodeFormat format, int width, int height, Map<EncodeHintType, ?> hints) {
        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(contents, format, width, height);
            writeToStream(bitMatrix, "png", os);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 
     * @param matrix
     * @param format
     * @param file
     * @throws IOException
     */
    public static void writeToFile(BitMatrix matrix, String format, File file) throws IOException {
        BufferedImage image = toBufferedImage(matrix);
        ImageIO.write(image, format, file);
    }
    
    public static void writeToStream(BitMatrix matrix, String format, OutputStream os) throws IOException {
        BufferedImage image = toBufferedImage(matrix);
        ImageIO.write(image, format, os);
    }

    /**
     * 
     * @param matrix
     * @return
     */
    public static BufferedImage toBufferedImage(BitMatrix matrix) {
        int width = matrix.getWidth();
        int height = matrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, matrix.get(x, y) == true ? BLACK : WHITE);
            }
        }
        return image;
    }

    @SuppressWarnings("unchecked")
    public void decode(File file) {
        try {
            BufferedImage image;
            try {
                image = ImageIO.read(file);
                if (image == null) {
                    System.out.println("Could not decode image");
                }
                LuminanceSource source = new BufferedImageLuminanceSource(image);
                BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
                Result result;
                @SuppressWarnings("rawtypes")
                Hashtable hints = new Hashtable();
                hints.put(DecodeHintType.CHARACTER_SET, "utf-8");
                result = new MultiFormatReader().decode(bitmap, hints);
                String resultStr = result.getText();
            } catch (IOException ioe) {
                System.out.println(ioe.toString());
            } catch (ReaderException re) {
                System.out.println(re.toString());
            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
    }
}