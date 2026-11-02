import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'my_programs_screen.dart';
import 'profile_screen.dart';
import 'program_listing_screen.dart';

class StudentShell extends StatefulWidget {
  const StudentShell({super.key});

  @override
  State<StudentShell> createState() => _StudentShellState();
}

class _StudentShellState extends State<StudentShell> {
  int _index = 0;

  void _go(int index) => setState(() => _index = index);

  Widget _page(int index) {
    switch (index) {
      case 1:
        return const ProgramListingScreen();
      case 2:
        return MyProgramsScreen(onBrowse: () => _go(1));
      case 3:
        return const ProfileScreen();
      default:
        return HomeScreen(onOpenTab: _go);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(_index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _go,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Programs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: 'My programs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}