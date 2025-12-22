
import 'package:flutter/material.dart';
import '../shared/shared_screens.dart';

class ManagerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manager Dashboard')),
      body: ListView(children: [
        ListTile(title: Text('Approvals'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ApprovalsUI()))),
ListTile(title: Text('Account States'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountStatesUI()))),
ListTile(title: Text('Reports'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportsUI()))),
ListTile(title: Text('Audit Logs'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AuditLogsUI()))),
      ]),
    );
  }
}
