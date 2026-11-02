import 'package:flutter/material.dart';
import '../data/feedback_store.dart';
import '../data/registrations_store.dart';
import '../data/user_session.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = UserSession.email.toLowerCase();
    final myRegistrations =
        registrations.where((r) => r.email.toLowerCase() == email).length;
    final myFeedback =
        feedbackEntries.where((f) => f.email.toLowerCase() == email).length;
    final initial =
        UserSession.name.isEmpty ? '?' : UserSession.name[0].toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primary,
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              UserSession.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              UserSession.email,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Chip(
              avatar: Icon(Icons.school_outlined, size: 18),
              label: Text('Student / Intern'),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: '$myRegistrations',
                  label: 'Registrations',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Stat(
                  value: '$myFeedback',
                  label: 'Feedback given',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About CURIOUS'),
              subtitle: const Text('Stay curious. Keep growing.'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'CURIOUS',
                  applicationVersion: '1.0.0',
                  children: const [
                    Text(
                      'A learning app built with Flutter for the Excelerate internship.',
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              UserSession.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;

  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(label, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}