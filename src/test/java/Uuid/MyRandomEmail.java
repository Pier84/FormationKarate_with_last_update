package Uuid;

import java.util.UUID;

public class MyRandomEmail {

    public static String generateRandomEmail() {
        String randomString = UUID.randomUUID().toString();
        return randomString.substring(0, randomString.indexOf('-')) + "@example.com";
    }
}
