
import 'package:bank_system/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(BankingUIApp());

class BankingUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',

      routes: appRoutes,
    );
  }
}
