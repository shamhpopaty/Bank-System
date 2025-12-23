


import '../../core/enums.dart';
import '../../data/mock_data.dart';
import '../models/account.dart';
import '../models/transaction.dart';
// import 'package:bank_app/domain/patterns/payment_adapter.dart';

class BankingService {

  /// ===============================
  /// Read Operations
  /// ===============================


  /// ===============================
  /// Write Operations (Patterns)
  /// ===============================
  // void submitTransaction(BankTransaction tx) {
  //
  //   // Chain of Responsibility
  //   MockData.approvalChain.handle(tx.amount);
  //
  //   // Adapter Pattern (Payment)
  //   if (tx.approved) {
  //     MockData.paymentProcessor.pay(tx.amount);
  //   }
  //
  //   // Observer Pattern
  //   MockData.notificationCenter.notify(
  //     'Transaction ${tx.id} submitted with amount ${tx.amount}',
  //   );
  //
  //   // Save transaction
  //   MockData.transactions.add(tx);
  // }
// import 'package:bank_app/domain/patterns/payment_adapter.dart';

  /// ===============================
  /// Read Operations
  /// ===============================
  List<Account> getAccounts() => MockData.accounts;

  List<BankTransaction> getTransactions() => MockData.transactions;

  /// ===============================
  /// Write Operations (Patterns)
  /// ===============================
  void submitTransaction(BankTransaction tx, {String? fromAccountId, String? toAccountId}) {

  // Chain of Responsibility
  MockData.approvalChain.handle(tx.amount);

  // Adapter Pattern (Payment)
  if (tx.approved) {
  MockData.paymentProcessor.pay(tx.amount);
  }

  // --- Logic to Update Balances (Linked to MockData) ---
  Account? fromAccount;
  Account? toAccount;

  try {
  if (fromAccountId != null) {
  // Find the account in the static list
  fromAccount = MockData.accounts.firstWhere((acc) => acc.id == fromAccountId);
  }
  if (toAccountId != null) {
  // Find the account in the static list
  toAccount = MockData.accounts.firstWhere((acc) => acc.id == toAccountId);
  }
  } catch (e) {
  // For a real system, this would throw a custom exception
  print('Error finding account: $e');
  }


  if (tx.approved) {
  if (tx.type == TransactionType.deposit && toAccount != null) {
    //Deposite
  toAccount.balance += tx.amount;
  } else if (tx.type == TransactionType.withdraw && fromAccount != null) {
  // In a real system, check for sufficient funds here
    //withdraw(saheb)
  fromAccount.balance -= tx.amount;
  } else if (tx.type == TransactionType.transfer && fromAccount != null && toAccount != null) {
  // In a real system, check for sufficient funds here
    //trnsfer(tahwel)
  fromAccount.balance -= tx.amount;
  toAccount.balance += tx.amount;
  }
  }
  // --- End Logic to Update Balances ---


  // Observer Pattern
  MockData.notificationCenter.notify(
  'Transaction ${tx.id} submitted with amount ${tx.amount}',
  );

  // Save transaction
  MockData.transactions.add(tx);
  }
  }

