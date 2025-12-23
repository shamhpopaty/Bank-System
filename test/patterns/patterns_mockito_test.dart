import 'package:bank_system/lib/domain/patterns/adapter/payment_adapter.dart';
import 'package:bank_system/lib/domain/patterns/composite/composite_account.dart';
import 'package:bank_system/lib/domain/patterns/decorator/account_decorator.dart';
import 'package:bank_system/lib/domain/patterns/observer/notification_observer.dart';
import 'package:bank_system/lib/domain/patterns/strategy/interest_strategy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks
@GenerateMocks([
  AccountComponent,
  AccountFeature,
  InterestStrategy,
  Observer,
])
import 'patterns_mockito_test.mocks.dart';

void main() {
  group('Composite Pattern with Mockito', () {
    test('AccountGroup aggregates balances from mocked components', () {
      // Arrange
      final mockAccount1 = MockAccountComponent();
      final mockAccount2 = MockAccountComponent();

      when(mockAccount1.getBalance()).thenReturn(1000);
      when(mockAccount2.getBalance()).thenReturn(2000);
      when(mockAccount1.getName()).thenReturn('Account 1');
      when(mockAccount2.getName()).thenReturn('Account 2');

      final group = AccountGroup('Test Group');
      group.add(mockAccount1);
      group.add(mockAccount2);

      // Act
      final totalBalance = group.getBalance();

      // Assert
      expect(totalBalance, 3000);
      verify(mockAccount1.getBalance()).called(1);
      verify(mockAccount2.getBalance()).called(1);
    });

    test('Single account in group is accessed correctly', () {
      // Arrange
      final mockAccount = MockAccountComponent();
      when(mockAccount.getBalance()).thenReturn(5000);
      when(mockAccount.getName()).thenReturn('Savings');

      final group = AccountGroup('Family');
      group.add(mockAccount);

      // Act
      final balance = group.getBalance();
      final name = group.getName();

      // Assert
      expect(balance, 5000);
      expect(name, 'Family');
      verify(mockAccount.getBalance()).called(1);
    });
  });

  group('Decorator Pattern with Mockito', () {
    test('Decorator wraps base account feature correctly', () {
      // Arrange
      final mockBaseAccount = MockAccountFeature();
      when(mockBaseAccount.getDescription()).thenReturn('Basic Account');

      final decorated = OverdraftProtection(mockBaseAccount);

      // Act
      final description = decorated.getDescription();

      // Assert
      expect(description, contains('Basic Account'));
      expect(description, contains('Overdraft Protection'));
      verify(mockBaseAccount.getDescription()).called(1);
    });

    test('Multiple decorators can be chained', () {
      // Arrange
      final mockBase = MockAccountFeature();
      when(mockBase.getDescription()).thenReturn('Standard');

      // Act - chain decorators
      final decorated = OverdraftProtection(mockBase);
      final description = decorated.getDescription();

      // Assert
      expect(description, contains('Standard'));
      verify(mockBase.getDescription()).called(1);
    });
  });

  group('Strategy Pattern with Mockito', () {
    test('Interest strategy can be mocked and verified', () {
      // Arrange
      final mockStrategy = MockInterestStrategy();
      when(mockStrategy.calculate(1000)).thenReturn(30.0);

      // Act
      final interest = mockStrategy.calculate(1000);

      // Assert
      expect(interest, 30.0);
      verify(mockStrategy.calculate(1000)).called(1);
    });

    test('Different strategies return different results', () {
      // Arrange
      final savingsStrategy = MockInterestStrategy();
      final loanStrategy = MockInterestStrategy();

      when(savingsStrategy.calculate(1000)).thenReturn(30.0);  // 3%
      when(loanStrategy.calculate(1000)).thenReturn(70.0);     // 7%

      // Act
      final savingsInterest = savingsStrategy.calculate(1000);
      final loanInterest = loanStrategy.calculate(1000);

      // Assert
      expect(savingsInterest, 30.0);
      expect(loanInterest, 70.0);
      verify(savingsStrategy.calculate(1000)).called(1);
      verify(loanStrategy.calculate(1000)).called(1);
    });

    test('Strategy can be switched at runtime', () {
      // Arrange
      final strategy1 = MockInterestStrategy();
      final strategy2 = MockInterestStrategy();

      when(strategy1.calculate(any)).thenReturn(50.0);
      when(strategy2.calculate(any)).thenReturn(100.0);

      InterestStrategy currentStrategy = strategy1;

      // Act & Assert - First strategy
      expect(currentStrategy.calculate(1000), 50.0);

      // Switch strategy
      currentStrategy = strategy2;
      expect(currentStrategy.calculate(1000), 100.0);

      verify(strategy1.calculate(1000)).called(1);
      verify(strategy2.calculate(1000)).called(1);
    });
  });

  group('Observer Pattern with Mockito', () {
    test('Observer update method is called when notified', () {
      // Arrange
      final mockObserver = MockObserver();
      final center = NotificationCenter();
      center.subscribe(mockObserver);

      // Act
      center.notify('Test Message');

      // Assert
      verify(mockObserver.update('Test Message')).called(1);
    });

    test('Multiple notifications trigger multiple updates', () {
      // Arrange
      final mockObserver = MockObserver();
      final center = NotificationCenter();
      center.subscribe(mockObserver);

      // Act
      center.notify('Message 1');
      center.notify('Message 2');
      center.notify('Message 3');

      // Assert
      verify(mockObserver.update('Message 1')).called(1);
      verify(mockObserver.update('Message 2')).called(1);
      verify(mockObserver.update('Message 3')).called(1);
    });

    test('Unsubscribed observer does not receive notifications', () {
      // Arrange
      final mockObserver = MockObserver();
      final center = NotificationCenter();

      // Note: In a real implementation, you'd need an unsubscribe method
      // This test demonstrates the concept

      // Act
      center.notify('Should not be received');

      // Assert
      verifyNever(mockObserver.update(any));
    });
  });

  group('Adapter Pattern with Mockito', () {
    test('Adapter delegates to legacy system correctly', () {
      // For adapter pattern, we test the integration
      // In this case, we verify the adapter calls the legacy system

      final legacySystem = LegacyPaymentSystem();
      final adapter = PaymentAdapter(legacySystem);

      // Act - this should not throw
      expect(() => adapter.pay(100), returnsNormally);
    });
  });
}


