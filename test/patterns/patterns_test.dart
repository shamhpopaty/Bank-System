import 'package:bank_system/lib/domain/patterns/adapter/payment_adapter.dart';
import 'package:bank_system/lib/domain/patterns/chain/approval_chain.dart';
import 'package:bank_system/lib/domain/patterns/composite/composite_account.dart';
import 'package:bank_system/lib/domain/patterns/decorator/account_decorator.dart';
import 'package:bank_system/lib/domain/patterns/observer/notification_observer.dart';
import 'package:bank_system/lib/domain/patterns/strategy/interest_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Composite Pattern - AccountComponent', () {
    test('SingleAccount returns its own balance', () {
      final acc = SingleAccount('Test', 1000);
      expect(acc.getBalance(), 1000);
      expect(acc.getName(), 'Test');
    });

    test('AccountGroup returns sum of child balances', () {
      final group = AccountGroup('Group');
      group.add(SingleAccount('A', 1000));
      group.add(SingleAccount('B', -500));

      expect(group.getName(), 'Group');
      expect(group.getBalance(), 500); // 1000 + (-500)
    });
  });


  group('Decorator Pattern - AccountFeature', () {
    test('BasicAccount has simple description', () {
      final acc = BasicAccount();
      expect(acc.getDescription(), 'Basic Account');
    });

    test('OverdraftProtection decorates description', () {
      final acc = OverdraftProtection(BasicAccount());
      final desc = acc.getDescription();

      expect(desc, contains('Basic Account'));
      expect(desc, contains('Overdraft Protection'));
    });
  });
  group('Strategy Pattern - InterestStrategy', () {
    test('SavingsInterest is 3% of balance', () {
      final strategy = SavingsInterest();
      final result = strategy.calculate(1000);
      expect(result, 1000 * 0.03);
    });

    test('LoanInterest is 7% of balance', () {
      final strategy = LoanInterest();
      final result = strategy.calculate(2000);
      expect(result, 2000 * 0.07);
    });
  });


  group('Adapter Pattern - PaymentAdapter', () {
    test('PaymentAdapter calls LegacyPaymentSystem without error', () {
      final legacy = LegacyPaymentSystem();
      final adapter = PaymentAdapter(legacy);

      // ما في expect مهم هون، يكفي نتأكد إنو ما في استثناء
      adapter.pay(500);
    });
  });



  group('Chain of Responsibility - ApprovalHandler', () {
  test('Employee approves small amounts, manager handles larger', () {
  final employee = EmployeeApproval();
  final manager = ManagerApproval();
  employee.next = manager;

  // ما في assert على print، بس نتأكد ما في استثناء
  employee.handle(500);   // مفروض: Approved by Employee
  employee.handle(5000);  // مفروض: Approved by Manager
  });
  });

  group('Observer Pattern - NotificationCenter', () {
  test('notify calls update on subscribed observers', () {
  final center = NotificationCenter();
  final observer = TestObserver();

  center.subscribe(observer);
  center.notify('Hello');

  expect(observer.lastMessage, 'Hello');
  });
  });
}

class TestObserver implements Observer {
  String? lastMessage;

  @override
  void update(String message) {
    lastMessage = message;
  }
}

class TestApprovalHandler extends ApprovalHandler {
  String lastMessage = '';

  @override
  void handle(double amount) {
    if (amount <= 1000) {
      lastMessage = 'employee';
    } else {
      lastMessage = 'manager';
    }
  }
}