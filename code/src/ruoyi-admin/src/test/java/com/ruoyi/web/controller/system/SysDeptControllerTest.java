package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.system.service.ISysDeptService;
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

import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(SpringExtension.class)
@WebMvcTest(SysDeptController.class)
class SysDeptControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ISysDeptService mockDeptService;

    @Test
    void testList() throws Exception {
        // Setup
        // Configure ISysDeptService.selectDeptList(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        sysDept.setDeptName("deptName");
        sysDept.setStatus("status");
        final List<SysDept> sysDepts = Arrays.asList(sysDept);
        when(mockDeptService.selectDeptList(any(SysDept.class))).thenReturn(sysDepts);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/dept/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testList_ISysDeptServiceReturnsNoItems() throws Exception {
        // Setup
        when(mockDeptService.selectDeptList(any(SysDept.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/dept/list")
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExcludeChild() throws Exception {
        // Setup
        // Configure ISysDeptService.selectDeptList(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        sysDept.setDeptName("deptName");
        sysDept.setStatus("status");
        final List<SysDept> sysDepts = Arrays.asList(sysDept);
        when(mockDeptService.selectDeptList(any(SysDept.class))).thenReturn(sysDepts);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/dept/list/exclude/{deptId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testExcludeChild_ISysDeptServiceReturnsNoItems() throws Exception {
        // Setup
        when(mockDeptService.selectDeptList(any(SysDept.class))).thenReturn(Collections.emptyList());

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/dept/list/exclude/{deptId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testGetInfo() throws Exception {
        // Setup
        // Configure ISysDeptService.selectDeptById(...).
        final SysDept sysDept = new SysDept();
        sysDept.setCreateBy("createBy");
        sysDept.setUpdateBy("updateBy");
        sysDept.setDeptId(0L);
        sysDept.setParentId(0L);
        sysDept.setAncestors("ancestors");
        sysDept.setDeptName("deptName");
        sysDept.setStatus("status");
        when(mockDeptService.selectDeptById(0L)).thenReturn(sysDept);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(get("/system/dept/{deptId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockDeptService).checkDeptDataScope(0L);
    }

    @Test
    void testAdd() throws Exception {
        // Setup
        when(mockDeptService.checkDeptNameUnique(any(SysDept.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/dept")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testAdd_ISysDeptServiceCheckDeptNameUniqueReturnsTrue() throws Exception {
        // Setup
        when(mockDeptService.checkDeptNameUnique(any(SysDept.class))).thenReturn(true);
        when(mockDeptService.insertDept(any(SysDept.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(post("/system/dept")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testEdit() throws Exception {
        // Setup
        when(mockDeptService.checkDeptNameUnique(any(SysDept.class))).thenReturn(false);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/dept")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockDeptService).checkDeptDataScope(0L);
    }

    @Test
    void testEdit_ISysDeptServiceCheckDeptNameUniqueReturnsTrue() throws Exception {
        // Setup
        when(mockDeptService.checkDeptNameUnique(any(SysDept.class))).thenReturn(true);
        when(mockDeptService.selectNormalChildrenDeptById(0L)).thenReturn(0);
        when(mockDeptService.updateDept(any(SysDept.class))).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(put("/system/dept")
                        .content("content").contentType(MediaType.APPLICATION_JSON)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockDeptService).checkDeptDataScope(0L);
    }

    @Test
    void testRemove() throws Exception {
        // Setup
        when(mockDeptService.hasChildByDeptId(0L)).thenReturn(false);
        when(mockDeptService.checkDeptExistUser(0L)).thenReturn(false);
        when(mockDeptService.deleteDeptById(0L)).thenReturn(0);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/dept/{deptId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
        verify(mockDeptService).checkDeptDataScope(0L);
    }

    @Test
    void testRemove_ISysDeptServiceHasChildByDeptIdReturnsTrue() throws Exception {
        // Setup
        when(mockDeptService.hasChildByDeptId(0L)).thenReturn(true);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/dept/{deptId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }

    @Test
    void testRemove_ISysDeptServiceCheckDeptExistUserReturnsTrue() throws Exception {
        // Setup
        when(mockDeptService.hasChildByDeptId(0L)).thenReturn(false);
        when(mockDeptService.checkDeptExistUser(0L)).thenReturn(true);

        // Run the test
        final MockHttpServletResponse response = mockMvc.perform(delete("/system/dept/{deptId}", 0)
                        .with(user("username"))
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        // Verify the results
        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
        assertThat(response.getContentAsString()).isEqualTo("expectedResponse");
    }
}
