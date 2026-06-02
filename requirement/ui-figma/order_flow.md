
# Card Withdrawal & Settlement Flow

```mermaid
flowchart TD

    Start[Order Status Check] --> Status{Order Status?}

    %% ==================== PRE_INVOICE PATH ====================
    Status -->|pre_invoice| Empty{disbursement_records Empty?}

    Empty -->|No| ShowExisting[Show Existing Records]
    Empty -->|Yes| Click[User Clicks 'تخلیه  ']

    Click --> AmountSheet[ClearanceAmountSheet\nEnter Amount]
    AmountSheet --> API[Check Amount API]
    API --> Gateway{Gateway Type?}

    Gateway -->|Online| OTP[OTP Clearance Sheet]
    OTP --> EnterOTP[Enter 5-digit OTP]
    EnterOTP --> OTPCheck{OTP Correct?}
    OTPCheck -->|Yes| WithdrawalSuccess[Withdrawal Success]
    OTPCheck -->|No| EnterOTP

    Gateway -->|Offline| OfflineSection[ClearanceOperationSection]
    OfflineSection --> Upload[Upload Documents]
    Upload --> Submit[Submit Documents]
    Submit --> DocSuccess[Documents Sent Successfully]

    %% Amount Analysis
    WithdrawalSuccess --> AmountCheck{Amount vs Order Amount?}
    DocSuccess --> AmountCheck

    AmountCheck -->|Exact or More| Complete[Payment Completed\n→ approved]

    AmountCheck -->|Less| Awaiting[Set Order Status = awaiting_settlement]
    Awaiting --> SettlementWidget[Show Settlement Widget]

    %% ==================== SETTLEMENT PATH ====================
    SettlementWidget --> Method{Settlement Method}

    Method -->|1. Cash Settlement| Cash[Send Payment Link to Customer]
    Method -->|2. Online Gateway| OnlinePay[Open Payment Gateway]
    Method -->|3. Offline Receipt| Receipt[Upload Settlement Receipt]
    Method -->|4. Wallet Settlement| Wallet[Check Wallet Balance]

    Cash --> Paid[Customer Pays]
    OnlinePay --> PaySuccess[Payment Success]
    Receipt --> Pending[Pending Review]
    Wallet --> WalletCheck{Sufficient?}
    WalletCheck -->|Yes| WalletSuccess[Wallet Settlement Success]
    WalletCheck -->|No| Error[Show Error]

    %% Final States
    Complete --> Finished[Financial Process Completed]
    Paid --> Finished
    PaySuccess --> Finished
    WalletSuccess --> Finished
    Pending --> UnderReview[Order Status → under_review]

    %% Other Statuses
    Status -->|under_review| UR[Under Review Status]
    Status -->|approved| Approved[Approved / Completed]
    Status -->|rejected| Rejected[Rejected Status]
    Status -->|awaiting_settlement| SettlementWidget

    style Click fill:#4ade80,stroke:#166534
    style SettlementWidget fill:#fcd34d,stroke:#b45309
    style Method fill:#60a5fa,stroke:#1e40af