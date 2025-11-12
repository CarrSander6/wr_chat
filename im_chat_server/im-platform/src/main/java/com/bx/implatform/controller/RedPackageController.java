package com.bx.implatform.controller;

import com.bx.implatform.dto.PrivateMessageDTO;
import com.bx.implatform.dto.RedpacketDto;
import com.bx.implatform.dto.RobRedpackageDto;
import com.bx.implatform.result.Result;
import com.bx.implatform.result.ResultUtils;
import com.bx.implatform.service.UserService;
import com.bx.implatform.vo.PrivateMessageVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;

@Tag(name = "红包接口")
@RestController
@RequestMapping("/redPackage")
@RequiredArgsConstructor
public class RedPackageController {

    private final UserService userService;

    @PostMapping("/handout")
    @Operation(summary = "发红包", description = "发红包")
    public Result<String> sendMessage(@Valid @RequestBody RedpacketDto dto) {
        return ResultUtils.success(userService.handout(dto), "操作成功");
    }

    @PostMapping("/rob")
    @Operation(summary = "抢红包", description = "抢红包")
    public Result<BigDecimal> sendMessage(@Valid @RequestBody RobRedpackageDto dto) {
        return ResultUtils.success(userService.rob(dto), "操作成功");
    }
}
