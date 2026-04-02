# Bank-Customer-Analysis
A data analysis portfolio project using a simulated bank customer dataset. Covers SQL querying and Excel dashboards to extract meaningful financial insights.

## 🗄️ Dataset Overview

### `bank_customers.csv`
| Column | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `first_name` / `last_name` | Customer name |
| `age` / `gender` / `city` | Demographics |
| `account_type` | Savings or Checking |
| `account_balance` | Current balance (CAD) |
| `loan_amount` | Outstanding loan (0 if none) |
| `loan_status` | Active / Paid Off / No Loan |
| `account_open_date` | Date account was opened |

### `bank_transactions.csv`
| Column | Description |
|---|---|
| `transaction_id` | Unique transaction ID |
| `customer_id` | Links to customer table |
| `transaction_date` | Date of transaction |
| `transaction_type` | Credit or Debit |
| `amount` | Transaction amount (CAD) |
| `merchant` | Merchant or source name |
| `category` | Spending category |
