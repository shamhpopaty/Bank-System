abstract class AccountComponent {
  String getName();
  double getBalance();
}

class SingleAccount implements AccountComponent {
  final String name;
  final double balance;

  SingleAccount(this.name, this.balance);

  @override
  String getName() => name;

  @override
  double getBalance() => balance;
}

class AccountGroup implements AccountComponent {
  final String groupName;
  final List<AccountComponent> accounts = [];

  AccountGroup(this.groupName);

  void add(AccountComponent account) {
    accounts.add(account);
  }

  @override
  String getName() => groupName;

  @override
  double getBalance() {
    return accounts.fold(0, (sum, acc) => sum + acc.getBalance());
  }
}
