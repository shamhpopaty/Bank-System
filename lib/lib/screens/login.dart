
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String route = '/client';
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(children: [
          TextFormField(decoration: InputDecoration(labelText: 'Email')),
          TextFormField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Role'),
            items: [
              DropdownMenuItem(value: '/client', child: Text('Client')),
              DropdownMenuItem(value: '/employee', child: Text('Employee')),
              DropdownMenuItem(value: '/manager', child: Text('Manager')),
              DropdownMenuItem(value: '/admin', child: Text('Admin')),
            ],
            onChanged: (v) => route = v ?? '/client',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, route),
            child: Text('Login'),
          )
        ]),
      ),
    );
  }
}
