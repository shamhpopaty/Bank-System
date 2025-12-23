
import 'package:bank_system/lib/core/enums.dart';
import 'package:bank_system/lib/data/mock_data.dart';
import 'package:bank_system/lib/domain/models/transaction.dart';
import 'package:bank_system/lib/domain/services/banking_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Integration Test - BankingService', () {
    test('Full transaction flow works', () {
      final service = BankingService();

      final initialCount = MockData.transactions.length;
      final initialBalance1 = MockData.accounts.firstWhere((acc) => acc.id == '1').balance;
      final initialBalance2 = MockData.accounts.firstWhere((acc) => acc.id == '2').balance;
      const transferAmount = 500.0;

      final tx = BankTransaction(
        id: 'T999',
        type: TransactionType.transfer,
        amount: transferAmount,
        date: DateTime.now(),
        approved: true, // حتى يمر من الـ Adapter
      );

      // Act: Submit a transfer from Account 1 to Account 2
      service.submitTransaction(tx, fromAccountId: '1', toAccountId: '2');

      // Assertions
      // 1) انضافت العملية
      expect(MockData.transactions.length, initialCount + 1);

      // 2) تحديث رصيد الحساب المرسل
      final finalBalance1 = MockData.accounts.firstWhere((acc) => acc.id == '1').balance;
      expect(finalBalance1, initialBalance1 - transferAmount);

      // 3) تحديث رصيد الحساب المستقبل
      final finalBalance2 = MockData.accounts.firstWhere((acc) => acc.id == '2').balance;
      expect(finalBalance2, initialBalance2 + transferAmount);
    });

    test('Deposit transaction updates balance correctly', () {
      final service = BankingService();
      final accountId = '2';
      final initialBalance = MockData.accounts.firstWhere((acc) => acc.id == accountId).balance;
      const depositAmount = 100.0;

      final tx = BankTransaction(
        id: 'T1000',
        type: TransactionType.deposit,
        amount: depositAmount,
        date: DateTime.now(),
        approved: true,
      );

      // Act: Submit a deposit to Account 2
      service.submitTransaction(tx, toAccountId: accountId);

      // Assertions
      final finalBalance = MockData.accounts.firstWhere((acc) => acc.id == accountId).balance;
      expect(finalBalance, initialBalance + depositAmount);
    });

    test('Withdraw transaction updates balance correctly', () {
      final service = BankingService();
      final accountId = '2';
      final initialBalance = MockData.accounts.firstWhere((acc) => acc.id == accountId).balance;
      const withdrawAmount = 50.0;

      final tx = BankTransaction(
        id: 'T1001',
        type: TransactionType.withdraw,
        amount: withdrawAmount,
        date: DateTime.now(),
        approved: true,
      );

      // Act: Submit a withdraw from Account 2
      service.submitTransaction(tx, fromAccountId: accountId);

      // Assertions
      final finalBalance = MockData.accounts.firstWhere((acc) => acc.id == accountId).balance;
      expect(finalBalance, initialBalance - withdrawAmount);
    });
  });
}