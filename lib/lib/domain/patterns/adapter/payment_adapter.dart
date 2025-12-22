abstract class PaymentProcessor {
  void pay(double amount);
}

class LegacyPaymentSystem {
  void makePayment(double amount) {
    print('Legacy payment of $amount');
  }
}

class PaymentAdapter implements PaymentProcessor {
  final LegacyPaymentSystem legacySystem;

  PaymentAdapter(this.legacySystem);

  @override
  void pay(double amount) {
    legacySystem.makePayment(amount);
  }
}
