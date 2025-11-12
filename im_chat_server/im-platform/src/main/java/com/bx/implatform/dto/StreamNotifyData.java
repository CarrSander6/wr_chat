package com.bx.implatform.dto;

import lombok.Data;

import java.util.List;

@Data
public class StreamNotifyData {

    private Boolean confirmed;
    private String chainId;
    private List<ABIEntry> abi;
    private String streamId;
    private String tag;
    private Integer retries;
    private Block block;
    private List<Log> logs;
    private List<Transaction> txs;
    private List<InternalTransaction> txsInternal;
    private List<Erc20Transfer> erc20Transfers;
    private List<Erc20Approval> erc20Approvals;
    private List<NftTokenApproval> nftTokenApprovals;
    private NftApproval nftApprovals;
    private List<NftTransfer> nftTransfers;
    private List<NativeBalance> nativeBalances;

    @Data
    public static class Block {
        private String number;
        private String hash;
        private String timestamp;
        private String parentHash;
        private String nonce;
        private String sha3Uncles;
        private String logsBloom;
        private String transactionsRoot;
        private String stateRoot;
        private String miner;
        private String difficulty;
        private String totalDifficulty;
        private String extraData;
        private String size;
        private String gasLimit;
        private String gasUsed;
        private String baseFeePerGas;
    }
    @Data
    public static class NftTokenApproval {
        private String transactionHash;
        private String logIndex;
        private String owner;
        private String approved;    // 被授权的地址
        private String tokenId;     // 授权的代币ID
        private String contract;    // 合约地址
        private String tokenType;   // "ERC721" 或 "ERC1155"
        private String blockNumber;
        private String blockHash;
        private List<String> triggeredBy; // 触发此事件的地址列表
    }

    @Data
    public static class Log {
        private String logIndex;
        private String transactionIndex;
        private String transactionHash;
        private String blockHash;
        private String blockNumber;
        private String address;
        private String data;
        private String topic0;
        private String topic1;
        private String topic2;
        private String topic3;
        private Boolean removed;
        private List<String> triggeredBy;
    }

    @Data
    public static class Erc20Transfer {
        private String transactionHash;
        private String logIndex;
        private String contract;
        private List<String> triggeredBy;
        private String from;
        private String to;
        private String value;
        private String tokenName;
        private String tokenSymbol;
        private String tokenDecimals;
        private Boolean possibleSpam;
        private String valueWithDecimals;
        private String blockNumber;
        private String blockHash;
        private String transactionIndex;
    }

    @Data
    public static class Erc20Approval {
        private String transactionHash;
        private String logIndex;
        private String owner;
        private String spender;
        private String value;
        private String contract;
        private String tokenName;
        private String tokenSymbol;
        private String blockNumber;
        private String blockHash;
    }

    @Data
    public static class NftApproval {
        private List<ERC721Approval> ERC721;
        private List<ERC1155Approval> ERC1155;
    }
    @Data
    public static class ERC721Approval {
        private String transactionHash;
        private String logIndex;
        private String owner;
        private String approved;
        private String tokenId;
        private String contract;
        private String blockNumber;
        private String blockHash;
    }
    @Data
    public static class ERC1155Approval {
        private String transactionHash;
        private String logIndex;
        private String owner;
        private String operator;
        private Boolean approved;
        private String contract;
        private String blockNumber;
        private String blockHash;
    }
    @Data
    public static class NftTransfer {
        private String transactionHash;
        private String logIndex;
        private String from;
        private String to;
        private String tokenId;
        private String contract;
        private String tokenType; // "ERC721" or "ERC1155"
        private String value; // For ERC1155 only
        private String tokenName;
        private String tokenSymbol;
        private String blockNumber;
        private String blockHash;
    }
    @Data
    public static class NativeBalance {
        private String address;
        private String balance;
        private String blockNumber;
        private String blockHash;
    }
    @Data
    public static class Transaction {
        private String hash;
        private String nonce;
        private String blockHash;
        private String blockNumber;
        private String transactionIndex;
        private String from;
        private String to;
        private String value;
        private String gas;
        private String gasPrice;
        private String input;
        private String v;
        private String r;
        private String s;
        private String type;
        private String maxFeePerGas;
        private String maxPriorityFeePerGas;
        private String chainId;
    }
    @Data
    public static class InternalTransaction {
        private String transactionHash;
        private String from;
        private String to;
        private String value;
        private String gas;
        private String gasUsed;
        private String input;
        private String output;
        private String blockNumber;
        private String blockHash;
        private String type; // "call" or "create"
    }
    @Data
    public static class ABIEntry {
        private Boolean anonymous;
        private Boolean constant;
        private List<ABIInput> inputs;
        private String name;
        private List<ABIOutput> outputs;
        private Boolean payable;
        private String stateMutability;
        private String type;
        private String gas;
    }

    @Data
    public static class ABIInput {
        private String name;
        private String type;
        private Boolean indexed;
    }

    @Data
    public static class ABIOutput {
        private String name;
        private String type;
    }
}
