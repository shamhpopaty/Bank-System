


import '../../data/mock_data.dart';
import '../models/account.dart';
import '../models/transaction.dart';
// import 'package:bank_app/domain/patterns/payment_adapter.dart';

class BankingService {

  /// ===============================
  /// Read Operations
  /// ===============================
  List<Account> getAccounts() => MockData.accounts;

  List<BankTransaction> getTransactions() => MockData.transactions;

  /// ===============================
  /// Write Operations (Patterns)
  /// ===============================
  void submitTransaction(BankTransaction tx) {

    // Chain of Responsibility
    MockData.approvalChain.handle(tx.amount);

    // Adapter Pattern (Payment)
    if (tx.approved) {
      MockData.paymentProcessor.pay(tx.amount);
    }

    // Observer Pattern
    MockData.notificationCenter.notify(
      'Transaction ${tx.id} submitted with amount ${tx.amount}',
    );

    // Save transaction
    MockData.transactions.add(tx);
  }
}
