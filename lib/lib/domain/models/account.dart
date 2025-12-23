import '../../core/enums.dart';

class Account {
  final String id;
  final String name;
  final String type;
  double balance;

  AccountState state;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.state,
  });
}
