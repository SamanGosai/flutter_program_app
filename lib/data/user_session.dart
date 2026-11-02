class UserSession {
  static String name = 'Guest';
  static String email = '';
  static bool isHost = false;

  static void login({required String email, required bool host}) {
    UserSession.email = email.trim();
    isHost = host;

    // Make a friendly name from the email, e.g. "akash.debnath@x.com" -> "Akash Debnath"
    final prefix = email.trim().split('@').first;
    final words = prefix
        .replaceAll(RegExp(r'[._0-9]+'), ' ')
        .trim()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .toList();
    name = words.isEmpty ? 'Guest' : words.join(' ');
  }

  static void logout() {
    name = 'Guest';
    email = '';
    isHost = false;
  }
}