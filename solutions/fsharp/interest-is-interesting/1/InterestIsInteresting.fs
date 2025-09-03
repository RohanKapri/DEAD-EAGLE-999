module InterestIsInteresting

let interestRate (balance: decimal): single =
    match balance with
    | b when b < 0m -> 3.213f
    | b when b < 1000m -> 0.5f
    | b when b >= 1000m && b < 5000m -> 1.621f
    | _ -> 2.475f

let interest (balance: decimal): decimal =
    (balance / 100m) * decimal (interestRate balance)

let annualBalanceUpdate(balance: decimal): decimal =
    balance + interest balance

let amountToDonate(balance: decimal) (taxFreePercentage: float): int =
    match balance with
    | b when b <= 0m -> 0
    | _ -> int (balance * decimal (taxFreePercentage / 100.0 * 2.0))