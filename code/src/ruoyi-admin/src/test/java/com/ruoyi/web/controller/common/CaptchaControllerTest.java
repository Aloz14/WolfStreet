package com.ruoyi.web.controller.common;

import com.google.code.kaptcha.Producer;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.system.service.ISysConfigService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.awt.image.BufferedImage;
import java.util.concurrent.TimeUnit;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(CaptchaController.class)
class CaptchaControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private Producer mockCaptchaProducer;
    @MockBean
    private Producer mockCaptchaProducerMath;
    @MockBean
    private RedisCache mockRedisCache;
    @MockBean
    private ISysConfigService mockConfigService;

    @Test
    void testGetCode() {
        // Setup
        when(mockConfigService.selectCaptchaEnabled()).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/captchaImage")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetCode_ISysConfigServiceReturnsTrue() {
        // Setup
        when(mockConfigService.selectCaptchaEnabled()).thenReturn(true);
        when(mockCaptchaProducerMath.createText()).thenReturn("result");
        when(mockCaptchaProducerMath.createImage("s")).thenReturn(new BufferedImage(0, 0, 0));
        when(mockCaptchaProducer.createText()).thenReturn("value");
        when(mockCaptchaProducer.createImage("s")).thenReturn(new BufferedImage(0, 0, 0));

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/captchaImage")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockRedisCache).setCacheObject("key", "value", 0, TimeUnit.MINUTES);
    }
}
