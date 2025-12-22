
import 'package:flutter/material.dart';
import 'lib/screens/login.dart';
import 'lib/screens/client/client_dashboard.dart';
import 'lib/screens/employee/employee_dashboard.dart';
import 'lib/screens/manager/manager_dashboard.dart';
import 'lib/screens/admin/admin_dashboard.dart';

final appRoutes = {
  '/login': (_) => LoginScreen(),
  '/client': (_) => ClientDashboard(),
  '/employee': (_) => EmployeeDashboard(),
  '/manager': (_) => ManagerDashboard(),
  '/admin': (_) => AdminDashboard(),
};
