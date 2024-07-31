// File: test/java/Uuid/TestRunner.java
package Uuid;

import com.intuit.karate.junit5.Karate;

class TestRunner {
    @Karate.Test
    Karate testRunner() {
        return Karate.run("classpath:ztrain/features");
    }
}
