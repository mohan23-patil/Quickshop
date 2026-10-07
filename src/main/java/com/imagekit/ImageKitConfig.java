package com.imagekit;

import io.imagekit.client.ImageKitClient;
import io.imagekit.client.okhttp.ImageKitOkHttpClient;

public class ImageKitConfig
{
    private static final String PRIVATE_KEY =
            System.getenv("IMAGEKIT_PRIVATE_KEY");

    static
    {
        System.out.println("=================================");
        System.out.println("ImageKit Private Key Loaded: "
                + (PRIVATE_KEY != null && !PRIVATE_KEY.isEmpty()));
        System.out.println("ImageKit Private Key Length: "
                + (PRIVATE_KEY == null ? 0 : PRIVATE_KEY.length()));
        System.out.println("=================================");
    }

    private static final ImageKitClient client =
            ImageKitOkHttpClient.builder()
                    .privateKey(PRIVATE_KEY)
                    .build();

    public static ImageKitClient getClient()
    {
        return client;
    }
}