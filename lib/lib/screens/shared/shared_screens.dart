

import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../domain/patterns/decorator/account_decorator.dart';
import '../../domain/patterns/strategy/interest_strategy.dart';

class AccountsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateAccountUI()),
          );
        },
      ),
      body:  ListView(
  children: [
    ListTile(
      title: Text(MockData.familyAccount.getName()),
      subtitle: Text('Composite Account (Composite Pattern)'),
      trailing: Text(
        MockData.familyAccount.getBalance().toString(),
      ),
    ),
  ],
),

    );
  }
}



class TransactionsUI extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('Transactions')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextFormField(decoration: InputDecoration(labelText: 'Amount')),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Type'),
              items: ['Deposit', 'Withdraw', 'Transfer']
                  .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {},
            ),
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
  MockData.paymentProcessor.pay(1000);

  MockData.notificationCenter.notify(
    'Payment processed via Adapter',
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Transaction submitted')),
  );
},

                child: Text('Submit'),
              ),
            )
          ]),
        ),
      );
}

class ScheduledTransactionsUI extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('Scheduled Transactions')),
        body: Column(children: [
          TextFormField(decoration: InputDecoration(labelText: 'Amount')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Schedule Date')),
          Builder(
            builder: (context) => ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Transaction scheduled')),
                  );
                },
                child: Text('Schedule')),
          )
        ]),
      );
}


class ReviewTransactionsUI extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('Review Transactions')),
        body: ListView(
          children: MockData.transactions.map((tx) {
            return ListTile(
              title: Text('Transaction ${tx.id}'),
              trailing: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    tx.approved = true;
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Approved'),
                        content: Text(
                            'Transaction approved successfully'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context),
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                  },
                  child: Text('Approve'),
                ),
              ),
            );
          }).toList(),
        ),
      );
}

class CustomerSupportUI extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('Customer Support')),
        body: Column(children: [
          TextFormField(
              decoration:
                  InputDecoration(labelText: 'Ticket Subject')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Message')),
          Builder(
            builder: (context) => ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Ticket sent to support')),
                  );
                },
                child: Text('Send')),
          )
        ]),
      );
}

class ApprovalsUI extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('Approvals')),
        body: ListView(children: [
          ListTile(
            title: Text('Large Transfer'),
            trailing: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
  MockData.approvalChain.handle(5000);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Approved'),
      content: Text('Handled via Chain of Responsibility'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        )
      ],
    ),
  );
},

                child: Text('Approve'),
              ),
            ),
          ),
        ]),
      );
}

class AccountStatesUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account States')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Builder(
          builder: (context) =>
              DropdownButtonFormField<String>(
            decoration:
                InputDecoration(labelText: 'Account State'),
            items: ['Active', 'Frozen', 'Suspended', 'Closed']
                .map(
                  (state) => DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  ),
                )
                .toList(),
            onChanged: (selectedState) {
              if (selectedState == null) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Account state changed to $selectedState'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



class UserManagementUI extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: Text('User Management')),
        body: Column(children: [
          TextFormField(
              decoration:
                  InputDecoration(labelText: 'User Email')),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Role'),
              items: ['Client', 'Employee', 'Manager', 'Admin']
                  .map((e) => DropdownMenuItem(
                      value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {}),
          Builder(
            builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('User Created'),
                      content:
                          Text('User created successfully'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          child: Text('OK'),
                        )
                      ],
                    ),
                  );
                },
                child: Text('Create User')),
          )
        ]),
      );
}


class RoleManagementUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Role Management')),
      body: ListView(
        children: [
          _roleTile(context, 'Client'),
          _roleTile(context, 'Employee'),
          _roleTile(context, 'Manager'),
          _roleTile(context, 'Admin'),
        ],
      ),
    );
  }

  Widget _roleTile(BuildContext context, String role) {
    return ListTile(
      title: Text(role),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RoleDetailsUI(roleName: role),
          ),
        );
      },
    );
  }
}

class RoleDetailsUI extends StatelessWidget {
  final String roleName;

  RoleDetailsUI({required this.roleName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$roleName Permissions')),
      body: ListView(
        children: _permissionsForRole(roleName),
      ),
    );
  }

  List<Widget> _permissionsForRole(String role) {
    switch (role) {
      case 'Client':
        return [
          _permissionTile('View Own Accounts', true),
          _permissionTile('Perform Transactions', true),
          _permissionTile('View Reports', false),
          _permissionTile('Manage Users', false),
        ];

      case 'Employee':
        return [
          _permissionTile('Review Transactions', true),
          _permissionTile('Customer Support', true),
          _permissionTile('View Reports', true),
          _permissionTile('Manage Users', false),
        ];

      case 'Manager':
        return [
          _permissionTile('Approve Transactions', true),
          _permissionTile('View Audit Logs', true),
          _permissionTile('View Reports', true),
          _permissionTile('Manage Users', false),
        ];

      case 'Admin':
        return [
          _permissionTile('Manage Users', true),
          _permissionTile('Manage Roles', true),
          _permissionTile('View System Reports', true),
          _permissionTile('View Audit Logs', true),
        ];

      default:
        return [];
    }
  }

  Widget _permissionTile(String title, bool enabled) {
    return CheckboxListTile(
      title: Text(title),
      value: enabled,
      onChanged: null, // UI-only (static)
    );
  }
}


class ReportsUI extends StatelessWidget {
  @override Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text('Reports')),
    body: Column(children: [
      TextFormField(decoration: InputDecoration(labelText: 'From')),
      TextFormField(decoration: InputDecoration(labelText: 'To')),
      Builder(
  builder: (context) =>ElevatedButton(
  onPressed: () {
    final strategy = SavingsInterest();
    final interest = strategy.calculate(5000);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calculated Interest: $interest'),
      ),
    );
  },
  child: Text('Generate'),
)
 )
    ]),
  );
}
class ReportResultUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Result')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(title: Text('Total Transactions'), trailing: Text('120')),
          ListTile(title: Text('Approved Transactions'), trailing: Text('98')),
          ListTile(title: Text('Rejected Transactions'), trailing: Text('22')),
          ListTile(title: Text('Pending Transactions'), trailing: Text('10')),
        ],
      ),
    );
  }
}


class AuditLogsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audit Logs')),
      body: ListView(
        children: [
          ListTile(
            title: Text('User X approved transaction'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AuditLogDetailsUI(
                  title: 'Transaction Approval',
                  description: 'User X approved a transaction of \$500',
                )),
              );
            },
          ),
          ListTile(
            title: Text('Account created'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AuditLogDetailsUI(
                  title: 'Account Creation',
                  description: 'A new savings account was created',
                )),
              );
            },
          ),
        ],
      ),
    );
  }
}
class AuditLogDetailsUI extends StatelessWidget {
  final String title;
  final String description;

  AuditLogDetailsUI({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Date: 2025-01-01'),
            Text('Performed By: System User'),
          ],
        ),
      ),
    );
  }
}


class NotificationsUI extends StatelessWidget {
  @override Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text('Notifications')),
    body: ListView(children: [
      ListTile(title: Text('Balance Updated')),
      ListTile(title: Text('Approval Required')),
    ]),
  );
}
class SystemReportsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('System Reports')),
      body: ListView(
        children: [
          ListTile(
            title: Text('System Usage Report'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SystemUsageReportDetailsUI()),
              );
            },
          ),
          ListTile(
            title: Text('Security Report'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SecurityReportDetailsUI()),
              );
            },
          ),
          ListTile(
            title: Text('Performance Report'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PerformanceReportDetailsUI()),
              );
            },
          ),
        ],
      ),
    );
  }
}
class SystemUsageReportDetailsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('System Usage Details')),
      body: ListView(
        children: [
          ListTile(title: Text('Total Users'), trailing: Text('350')),
          ListTile(title: Text('Daily Transactions'), trailing: Text('2400')),
          ListTile(title: Text('Active Accounts'), trailing: Text('1120')),
        ],
      ),
    );
  }
}

class SecurityReportDetailsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Security Report Details')),
      body: ListView(
        children: [
          ListTile(title: Text('Failed Login Attempts'), trailing: Text('12')),
          ListTile(title: Text('Locked Accounts'), trailing: Text('3')),
          ListTile(title: Text('Role Changes'), trailing: Text('5')),
        ],
      ),
    );
  }
}

class PerformanceReportDetailsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Performance Report Details')),
      body: ListView(
        children: [
          ListTile(title: Text('Avg Response Time'), trailing: Text('320 ms')),
          ListTile(title: Text('Peak Load'), trailing: Text('78%')),
        ],
      ),
    );
  }
}

class CreateAccountUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Account Name'),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Account Type'),
              items: [
                DropdownMenuItem(value: 'Savings', child: Text('Savings')),
                DropdownMenuItem(value: 'Current', child: Text('Current')),
                DropdownMenuItem(value: 'Loan', child: Text('Loan')),
                DropdownMenuItem(value: 'Investment', child: Text('Investment')),
              ],
              onChanged: (v) {},
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
  final basic = BasicAccount();
  final decorated =
      OverdraftProtection(basic);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(decorated.getDescription()),
    ),
  );

  Navigator.pop(context);
},

              child: Text('Create'),
            )
          ],
        ),
      ),
    );
  }
}
