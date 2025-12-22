abstract class AccountFeature {
  String getDescription();
}

class BasicAccount implements AccountFeature {
  @override
  String getDescription() => 'Basic Account';
}

class OverdraftProtection implements AccountFeature {
  final AccountFeature account;

  OverdraftProtection(this.account);

  @override
  String getDescription() =>
      '${account.getDescription()} + Overdraft Protection';
}
