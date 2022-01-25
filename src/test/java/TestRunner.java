import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate testSample() {
        return Karate.run("ui").relativeTo(getClass());
    }
}
