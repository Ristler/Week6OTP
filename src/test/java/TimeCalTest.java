import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class TimeCalTest {
    TimeCal tc = new TimeCal();


    @Test
    void calculateTime() {
        assertEquals(1.0, tc.calculateTime(100,100));

    }
}