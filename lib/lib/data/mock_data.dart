
import '../domain/models/account.dart';
import '../domain/models/transaction.dart';
import '../core/enums.dart';
import '../domain/patterns/adapter/payment_adapter.dart';
import '../domain/patterns/chain/approval_chain.dart';
import '../domain/patterns/composite/composite_account.dart';
import '../domain/patterns/decorator/account_decorator.dart';
import '../domain/patterns/observer/notification_observer.dart';
import '../domain/patterns/strategy/interest_strategy.dart';


class MockData {

  /// ===============================
  /// Observer Pattern
  /// ===============================
  static final NotificationCenter notificationCenter = NotificationCenter()
    ..subscribe(AppNotification());

  /// ===============================
  /// Composite Pattern
  /// ===============================
  static final AccountGroup familyAccount = AccountGroup('Family Account')
    ..add(SingleAccount('Savings Account', 5000))
    ..add(SingleAccount('Loan Account', -12000));

  /// ===============================
  /// Decorator Pattern
  /// ===============================
  static final AccountFeature decoratedAccount =
      OverdraftProtection(BasicAccount());

  /// ===============================
  /// Strategy Pattern
  /// ===============================
  static final InterestStrategy savingsInterest = SavingsInterest();
  static final InterestStrategy loanInterest = LoanInterest();

  /// ===============================
  /// Adapter Pattern
  /// ===============================
  static final PaymentProcessor paymentProcessor =
      PaymentAdapter(LegacyPaymentSystem());

  /// ===============================
  /// Chain of Responsibility
  /// ===============================
  static final ApprovalHandler approvalChain = _buildApprovalChain();

  /// ===============================
  /// UI-Compatible Accounts
  /// ===============================
  static List<Account> accounts = [
    Account(
      id: '1',
      name: familyAccount.getName(),
      type: 'Composite',
      balance: familyAccount.getBalance(),
      state: AccountState.active,
    ),
    Account(
      id: '2',
      name: 'Personal Savings',
      type: 'Savings',
      balance: savingsInterest.calculate(3000),
      state: AccountState.active,
    ),
  ];

  /// ===============================
  /// Transactions
  /// ===============================
  static List<BankTransaction> transactions = [
    BankTransaction(
      id: 'T1',
      type: TransactionType.deposit,
      amount: 1000,
      date: DateTime.now(),
      approved: true,
    ),
    BankTransaction(
      id: 'T2',
      type: TransactionType.transfer,
      amount: 5000,
      date: DateTime.now(),
      approved: _approveTransaction(5000),
    ),
  ];

  /// ===============================
  /// Helpers
  /// ===============================
  static ApprovalHandler _buildApprovalChain() {
    final employee = EmployeeApproval();
    final manager = ManagerApproval();

    employee.next = manager;
    return employee;
  }

  static bool _approveTransaction(double amount) {
    approvalChain.handle(amount);
    return true;
  }
}
