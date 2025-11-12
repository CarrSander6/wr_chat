package com.bx.implatform.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class BindWalletAddressDTO implements Serializable {

    /**
     * 钱包地址
     */
    private String walletAddress;
}
