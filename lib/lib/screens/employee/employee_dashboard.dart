
import 'package:flutter/material.dart';
import '../shared/shared_screens.dart';

class EmployeeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Dashboard')),
      body: ListView(children: [
        ListTile(title: Text('Review Transactions'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewTransactionsUI()))),
ListTile(title: Text('Customer Support'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerSupportUI()))),
ListTile(title: Text('Notifications'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsUI()))),
ListTile(title: Text('Reports'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportsUI()))),
      ]),
    );
  }
}
