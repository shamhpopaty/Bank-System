
import 'package:flutter/material.dart';
import '../shared/shared_screens.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: ListView(children: [
        ListTile(title: Text('User Management'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserManagementUI()))),
ListTile(title: Text('Role Management'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoleManagementUI()))),
ListTile(title: Text('System Reports'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SystemReportsUI()))),
ListTile(title: Text('Audit Logs'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AuditLogsUI()))),
      ]),
    );
  }
}
