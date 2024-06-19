package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.framework.web.service.SysRegisterService;
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

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysRegisterController.class)
class SysRegisterControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private SysRegisterService mockRegisterService;
    @MockBean
    private ISysConfigService mockConfigService;

    @Test
    void testRegister() {
        // Setup
        when(mockConfigService.selectConfigByKey("sys.account.registerUser")).thenReturn("result");
        when(mockRegisterService.register(any(RegisterBody.class))).thenReturn("result");

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/register")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
