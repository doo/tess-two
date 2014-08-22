package com.googlecode.tesseract.android;

/**
 * Java representation of a native Tesseract PDF renderer
 */
public class TessPdfRenderer {

    static {
        System.loadLibrary("tess");
    }

    private final long nativePointer;

    private boolean recycled;

    public TessPdfRenderer(TessBaseAPI tessBaseAPI, String outputPath) {
        this.nativePointer = nativeCreate(tessBaseAPI, outputPath);
        recycled = false;
    }

    /**
     * @return pointer to native data
     */
    long getNativePointer() {
        if (recycled) {
            throw new IllegalStateException("Already recycled");
        }

        return nativePointer;
    }

    /**
     * Frees native resources
     */
    public void recycle() {
        nativeRecycle(nativePointer);
        recycled = true;
    }

    private static native long nativeCreate(TessBaseAPI tessBaseAPI, String outputPath);

    private static native void nativeRecycle(long nativePointer);

}
