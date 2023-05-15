package com.bongsick.bongsick.utils;

import java.net.URI;
import java.net.URISyntaxException;

public class URLEncoder {
    public static String encode(String plainText){
        try {
            URI uri = new URI(plainText.replaceAll(" ", "%20")
                    .replaceAll("\\[", "%5B")
                    .replaceAll("]", "%5D"));
            return uri.toASCIIString();
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        encode("https://pcmap.place.naver.com/place/list?query=[강남 던전]");
    }
}
