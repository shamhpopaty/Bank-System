enum AccountState { active, frozen, suspended, closed }
enum TransactionType { deposit, withdraw, transfer }
enum UserRole { client, employee, manager, admin }
// AccountState enum removed, replaced by State Pattern (ActiveState, FrozenState, ClosedState)
