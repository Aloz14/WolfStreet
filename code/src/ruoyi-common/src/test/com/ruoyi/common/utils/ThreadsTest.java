package com.ruoyi.common.utils;

import org.junit.jupiter.api.Test;

import java.util.concurrent.ExecutorService;

import static org.mockito.Mockito.mock;

class ThreadsTest {

    @Test
    void testSleep() {
        // Setup
        // Run the test
        Threads.sleep(0L);

        // Verify the results
    }

    @Test
    void testShutdownAndAwaitTermination() {
        // Setup
        final ExecutorService mockPool = mock(ExecutorService.class);

        // Run the test
        Threads.shutdownAndAwaitTermination(mockPool);

        // Verify the results
    }

    @Test
    void testPrintException() {
        // Setup
        final Runnable r = null;

        // Run the test
        Threads.printException(r, new Exception("message"));

        // Verify the results
    }
}
