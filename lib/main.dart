import 'package:flutter/material.dart';
import 'screens/host_home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/student_shell.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CURIOUS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/student': (context) => const StudentShell(),
        '/host': (context) => const HostHomeScreen(),
      },
    );
  }
}