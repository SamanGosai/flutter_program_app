import 'package:flutter/material.dart';
import '../data/program_repository.dart';
import '../data/registrations_store.dart';
import '../data/user_session.dart';
import 'program_details_screen.dart';

class MyProgramsScreen extends StatelessWidget {
  final VoidCallback onBrowse;

  const MyProgramsScreen({super.key, required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    final email = UserSession.email.toLowerCase();
    final mine = registrations
        .where((r) => r.email.toLowerCase() == email)
        .toList()
        .reversed
        .toList();
    final programs = ProgramRepository.instance.programs;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My programs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: mine.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bookmark_border,
                        size: 64, color: Colors.black38),
                    const SizedBox(height: 12),
                    const Text(
                      'You have not registered yet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onBrowse,
                      child: const Text('Browse programs'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mine.length,
              itemBuilder: (context, index) {
                final r = mine[index];
                final matches =
                    programs.where((p) => p.title == r.programTitle);
                final program = matches.isEmpty ? null : matches.first;

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.check),
                    ),
                    title: Text(r.programTitle),
                    subtitle: Text('Registered as ${r.name} | ${r.yearOfStudy}'),
                    trailing: program == null
                        ? const Text('Removed')
                        : const Icon(Icons.chevron_right),
                    onTap: program == null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProgramDetailsScreen(program: program),
                              ),
                            );
                          },
                  ),
                );
              },
            ),
    );
  }
}