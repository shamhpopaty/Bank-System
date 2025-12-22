
import 'package:flutter/material.dart';
import '../shared/shared_screens.dart';

class ClientDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Client Dashboard')),
      body: ListView(children: [
        ListTile(title: Text('Accounts'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountsUI()))),
ListTile(title: Text('Transactions'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionsUI()))),
ListTile(title: Text('Scheduled Transactions'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduledTransactionsUI()))),
ListTile(title: Text('Notifications'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsUI()))),
ListTile(title: Text('Reports'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportsUI()))),
      ]),
    );
  }
}
