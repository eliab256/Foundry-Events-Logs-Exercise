# 🧩 EventLogs Exercise

### Author: [Elia Bordoni](https://www.linkedin.com/in/elia-bordoni/)

🔗 GitHub: [https://github.com/eliab256](https://github.com/eliab256)

---

## 📘 Overview

This project demonstrates **how to test Solidity events** using the **Foundry** framework.  
It focuses on capturing and decoding EVM logs with `vm.recordLogs()` to validate that events are correctly emitted, encoded, and decoded.

The exercise contains:

-   A `main` branch → the **starter template** (initial setup).
-   A `solution` branch → the **completed test implementation**.

---

## 🧠 Learning Objectives

By completing this exercise, you’ll learn how to:

-   Record EVM logs with `vm.recordLogs()` and access them using `vm.getRecordedLogs()`.
-   Understand the structure of `Vm.Log` (topics and data fields).
-   Decode event data manually using `abi.decode`.
-   Verify event signatures and indexed topics.
-   Handle dynamic data types (`string`, `uint256[]`) in events.

---

## 🧱 Project Structure

```
EventLogs-Exercise/
│
├── src/
│   └── EventLogger.sol         # The main contract emitting events
│
├── test/
│   └── EventLoggerTest.sol     # Foundry test suite (solution branch)
│
├── foundry.toml                # Foundry configuration file
└── README.md                   # Project documentation (this file)
```

---

## ⚙️ Installation & Setup

### 1️⃣ Clone the repository

```bash
git clone https://github.com/eliab256/EventLogs-Exercise.git
cd EventLogs-Exercise
```

### 2️⃣ Switch to the desired branch

-   For the **starter version**:
    ```bash
    git checkout main
    ```
-   For the **completed solution**:
    ```bash
    git checkout solution
    ```

### 3️⃣ Install dependencies

Ensure you have [Foundry](https://book.getfoundry.sh/) installed.  
If not, install it with:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Then build the project:

```bash
forge build
```

---

## 🧪 Running the Tests

To execute the test suite:

```bash
forge test -vvv
```

Recommended verbosity level:  
`-vvv` to display detailed output including event logs and decoded data.

---

## 🧠 Key Concepts Explained

### 🔹 Topics vs Data

-   `topics` contain **indexed parameters** of the event.
-   `data` contains **non-indexed parameters** (dynamic data like `string`, `bytes`, or arrays).

Example from the test:

```solidity
bytes32 eventSignature = fullEvent.topics[0]; // event signature (hashed)
bytes memory data = fullEvent.data;           // contains dynamic args
```

### 🔹 Event Decoding Example

```solidity
(string memory message, uint256 id) = abi.decode(data, (string, uint256));
```

### 🔹 Common Pitfall

Arrays and other dynamic types **cannot be indexed**.  
They are always stored in the `data` section of the log.

---

## 💡 Additional Notes

-   `assertEq()` can compare static and dynamic types, but **not raw bytes vs strings** directly — ensure both are properly encoded before comparing.
-   To compare addresses from topics:
    ```solidity
    address(uint160(uint256(topic)));
    ```
-   Always call `vm.recordLogs()` **before** emitting events, or the logs won’t be captured.

## 📜 License

This project is licensed under the **MIT License**.

---

**Created by [Elia Bordoni](https://www.linkedin.com/in/elia-bordoni/)**  
Blockchain Developer & Smart Contract Engineer  
GitHub: [eliab256](https://github.com/eliab256)
