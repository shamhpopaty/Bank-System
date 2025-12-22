abstract class InterestStrategy {
  double calculate(double balance);
}

class SavingsInterest implements InterestStrategy {
  @override
  double calculate(double balance) => balance * 0.03;
}

class LoanInterest implements InterestStrategy {
  @override
  double calculate(double balance) => balance * 0.07;
}
