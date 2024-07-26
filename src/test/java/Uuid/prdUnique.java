package Uuid;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class prdUnique {
    public static prdUnique instance = new prdUnique();
    public static Random rand = new Random(System.currentTimeMillis());

    private static List<Integer> generatedNumbers = new ArrayList();

    private prdUnique() {
    }

    public synchronized String unique() {

        SimpleDateFormat format = new SimpleDateFormat("yyyy");
        boolean found = false;
        int nextInt = 0;
        while (!found){
            nextInt = Math.abs(rand.nextInt());
            found = !generatedNumbers.contains(nextInt);
        }
        generatedNumbers.add(nextInt);
        return format.format(new Date()) + nextInt;

    }
}