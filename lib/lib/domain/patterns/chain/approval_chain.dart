abstract class ApprovalHandler {
  ApprovalHandler? next;
  void handle(double amount);
}

class EmployeeApproval extends ApprovalHandler {
  @override
  void handle(double amount) {
    if (amount <= 1000) {
      print('Approved by Employee');
    } else {
      next?.handle(amount);
    }
  }
}

class ManagerApproval extends ApprovalHandler {
  @override
  void handle(double amount) {
    print('Approved by Manager');
  }
}
