
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

      final tx = BankTransaction(
        id: 'T999',
        type: TransactionType.transfer,
        amount: 2000,
        date: DateTime.now(),
        approved: true, // حتى يمر من الـ Adapter
      );

      service.submitTransaction(tx);

      // 1) انضافت العملية
      expect(MockData.transactions.length, initialCount + 1);

      // هنا ممكن لاحقاً تضيف منطق زيادة (مثل تغير رصيد حساب، لو طبقت ذلك)
    });
  });
}