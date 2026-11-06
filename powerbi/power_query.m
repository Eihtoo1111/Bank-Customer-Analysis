// Power Query (M) — paste into Advanced Editor for each table.
// Update FolderPath to where you cloned the repo.

// ---- bank_customers ----
let
    FolderPath = "C:\Projects\Bank-Customer-Analysis\",
    Source = Csv.Document(File.Contents(FolderPath & "bank_customers.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.None]),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumnTypes(Headers, {
        {"customer_id", type text}, {"first_name", type text}, {"last_name", type text},
        {"age", Int64.Type}, {"gender", type text}, {"city", type text},
        {"account_type", type text}, {"account_balance", Currency.Type},
        {"loan_amount", Currency.Type}, {"loan_status", type text}, {"account_open_date", type date}}),
    FullName = Table.AddColumn(Typed, "full_name", each [first_name] & " " & [last_name], type text),
    Tenure = Table.AddColumn(FullName, "tenure_years", each Duration.Days(#date(2024, 3, 31) - [account_open_date]) / 365.25, type number)
in
    Tenure

// ---- bank_transactions ----
let
    FolderPath = "C:\Projects\Bank-Customer-Analysis\",
    Source = Csv.Document(File.Contents(FolderPath & "bank_transactions.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.None]),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumnTypes(Headers, {
        {"transaction_id", type text}, {"customer_id", type text},
        {"transaction_date", type date}, {"transaction_type", type text},
        {"amount", Currency.Type}, {"merchant", type text}, {"category", type text}}),
    Month = Table.AddColumn(Typed, "month", each Date.StartOfMonth([transaction_date]), type date)
in
    Month
