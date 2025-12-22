import '../../core/enums.dart';

class BankTransaction {
  final String id;
  final TransactionType type;
  final double amount;
  final DateTime date;
  bool approved;

  BankTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    this.approved = false,
  });
}
