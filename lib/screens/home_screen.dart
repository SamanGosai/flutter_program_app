import 'package:flutter/material.dart';
import '../data/program_repository.dart';
import '../data/user_session.dart';
import '../theme/app_theme.dart';
import 'program_details_screen.dart';

// Use the same image name as before
const _dashboardImage = 'assets/images/deshboard.png';

const _sectionStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

class HomeScreen extends StatefulWidget {
  final ValueChanged<int> onOpenTab;

  const HomeScreen({super.key, required this.onOpenTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = ProgramRepository.instance;

  @override
  void initState() {
    super.initState();
    repo.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CURIOUS',
          style: TextStyle(letterSpacing: 4, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => widget.onOpenTab(3),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_dashboardImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: ListenableBuilder(
          listenable: repo,
          builder: (context, _) {
            final featured = repo.programs.take(3).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Welcome, ${UserSession.name}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'What do you want to learn today?',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  onTap: () => widget.onOpenTab(1),
                  decoration: const InputDecoration(
                    hintText: 'Search programs',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Announcements', style: _sectionStyle),
                const SizedBox(height: 8),
                const Card(
                  color: Color(0xFFFFE8CC),
                  child: ListTile(
                    leading: Icon(Icons.campaign_outlined,
                        color: AppColors.primary),
                    title: Text('Upcoming workshop'),
                    subtitle:
                        Text('Flutter Basics workshop starts next Monday'),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Featured programs', style: _sectionStyle),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.secondary,
                      ),
                      onPressed: () => widget.onOpenTab(1),
                      child: const Text('See all'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (featured.isEmpty)
                  Text(
                    repo.error ?? 'Loading programs...',
                    style: const TextStyle(color: Colors.white70),
                  ),
                for (final p in featured)
                  Card(
                    child: ListTile(
                      leading:
                          const CircleAvatar(child: Icon(Icons.school_outlined)),
                      title: Text(p.title),
                      subtitle:
                          Text('${p.durationWeeks} weeks | Mentor: ${p.mentor}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProgramDetailsScreen(program: p),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}