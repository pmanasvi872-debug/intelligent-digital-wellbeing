import 'package:flutter/material.dart';
import 'services/usage_service.dart';
import 'database/database_service.dart';

void main() {
  runApp(const DigitalWellbeingApp());
}

class DigitalWellbeingApp extends StatelessWidget {
  const DigitalWellbeingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Wellbeing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

// ============================================================
// LOGIN SCREEN
// ============================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.health_and_safety,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                'Digital Wellbeing',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Understand your smartphone habits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Create an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REGISTER SCREEN
// ============================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const ProfileSetupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: register,
                  child: const Text(
                    'Create Account',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE SETUP SCREEN
// ============================================================

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() =>
      _ProfileSetupScreenState();
}

class _ProfileSetupScreenState
    extends State<ProfileSetupScreen> {
  final TextEditingController goalController =
      TextEditingController();

  @override
  void dispose() {
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us about your goal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'This will help personalize your digital wellbeing experience.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: goalController,
              decoration: InputDecoration(
                labelText: 'Your wellbeing goal',
                hintText:
                    'Example: Reduce social media usage',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Continue',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingUsage = false;

  List<dynamic> usageData = [];

  List<dynamic> usageEvents = [];

  // ==========================================================
  // APP NAME MAPPING
  // ==========================================================

  String getAppDisplayName(String? packageName) {
    if (packageName == null ||
        packageName.trim().isEmpty) {
      return 'Unknown App';
    }

    const appNames = {
      'com.example.intelligent_digital_wellbeing':
          'Digital Wellbeing',

      'com.android.launcher3':
          'Android Launcher',

      'com.google.android.apps.nexuslauncher':
          'Pixel Launcher',

      'com.android.settings':
          'Settings',

      'com.android.chrome':
          'Chrome',

      'com.google.android.youtube':
          'YouTube',

      'com.google.android.gm':
          'Gmail',

      'com.google.android.apps.maps':
          'Google Maps',

      'com.google.android.apps.photos':
          'Google Photos',

      'com.google.android.googlequicksearchbox':
          'Google',

      'com.google.android.apps.messaging':
          'Google Messages',

      'com.google.android.vending':
          'Google Play Store',

      'com.whatsapp':
          'WhatsApp',

      'com.instagram.android':
          'Instagram',

      'com.facebook.katana':
          'Facebook',

      'com.spotify.music':
          'Spotify',

      'com.microsoft.teams':
          'Microsoft Teams',

      'com.linkedin.android':
          'LinkedIn',
    };

    if (appNames.containsKey(packageName)) {
      return appNames[packageName]!;
    }

    // Fallback for apps that are not in the mapping.
    String name = packageName
        .split('.')
        .last
        .replaceAll('_', ' ')
        .replaceAll('-', ' ');

    if (name.isEmpty) {
      return packageName;
    }

    return name[0].toUpperCase() + name.substring(1);
  }

  // ==========================================================
  // TOTAL USAGE TIME
  // ==========================================================

  String getTotalUsageTime() {
    int totalMilliseconds = 0;

    for (final app in usageData) {
      final usageTime = app['usageTime'];

      if (usageTime != null) {
        totalMilliseconds +=
            (usageTime as num).toInt();
      }
    }

    final totalMinutes =
        totalMilliseconds ~/ (1000 * 60);

    final hours = totalMinutes ~/ 60;

    final minutes = totalMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }

    return '${minutes}m';
  }

  // ==========================================================
  // WELLBEING STATUS
  // ==========================================================

  String getWellbeingStatus() {
    int totalMilliseconds = 0;

    for (final app in usageData) {
      final usageTime = app['usageTime'];

      if (usageTime != null) {
        totalMilliseconds +=
            (usageTime as num).toInt();
      }
    }

    final totalHours =
        totalMilliseconds /
            (1000 * 60 * 60);

    if (totalHours < 3) {
      return 'Good';
    } else if (totalHours < 6) {
      return 'Moderate';
    } else {
      return 'Needs Attention';
    }
  }

  // ==========================================================
  // FOCUS PERCENTAGE
  // ==========================================================

  String getFocusPercentage() {
    int totalMilliseconds = 0;

    for (final app in usageData) {
      final usageTime = app['usageTime'];

      if (usageTime != null) {
        totalMilliseconds +=
            (usageTime as num).toInt();
      }
    }

    final totalHours =
        totalMilliseconds /
            (1000 * 60 * 60);

    int focusScore;

    if (totalHours < 2) {
      focusScore = 90;
    } else if (totalHours < 4) {
      focusScore = 80;
    } else if (totalHours < 6) {
      focusScore = 65;
    } else if (totalHours < 8) {
      focusScore = 50;
    } else {
      focusScore = 35;
    }

    return '$focusScore%';
  }

  // ==========================================================
  // SESSION COUNT
  // ==========================================================

  int getSessionCount() {
    int count = 0;

    for (final event in usageEvents) {
      if (event['eventType'] == 'foreground') {
        count++;
      }
    }

    return count;
  }

  // ==========================================================
  // APP SWITCH COUNT
  // ==========================================================

  int getAppSwitchCount() {
    int count = 0;

    String? previousPackage;

    for (final event in usageEvents) {
      if (event['eventType'] == 'foreground') {
        final packageName =
            event['packageName']?.toString();

        if (packageName != null) {
          if (previousPackage != null &&
              previousPackage != packageName) {
            count++;
          }

          previousPackage = packageName;
        }
      }
    }

    return count;
  }

  // ==========================================================
  // MOST REOPENED APP
  // ==========================================================

  String getMostReopenedApp() {
    final Map<String, int> appOpenCount = {};

    for (final event in usageEvents) {
      if (event['eventType'] == 'foreground') {
        final packageName =
            event['packageName']?.toString();

        if (packageName != null) {
          appOpenCount[packageName] =
              (appOpenCount[packageName] ?? 0) + 1;
        }
      }
    }

    if (appOpenCount.isEmpty) {
      return 'No data';
    }

    String mostReopened = appOpenCount.keys.first;

    int highestCount =
        appOpenCount[mostReopened] ?? 0;

    for (final entry in appOpenCount.entries) {
      if (entry.value > highestCount) {
        mostReopened = entry.key;
        highestCount = entry.value;
      }
    }

    return getAppDisplayName(mostReopened);
  }

  // ==========================================================
  // LOAD USAGE DATA
  // ==========================================================

  Future<void> loadUsageData() async {
    setState(() {
      isLoadingUsage = true;
    });

    try {
      final data =
          await UsageService.getUsageStats();

      final events =
          await UsageService.getUsageEvents();

      if (!mounted) return;

      setState(() {
        usageData = data;
        usageEvents = events;
        isLoadingUsage = false;
      });

      // --------------------------------------------------------
      // CALCULATE TOTAL USAGE
      // --------------------------------------------------------

      int totalUsage = 0;

      for (final app in data) {
        final usageTime = app['usageTime'];

        if (usageTime != null) {
          totalUsage +=
              (usageTime as num).toInt();
        }
      }

      // --------------------------------------------------------
      // TODAY'S DATE
      // --------------------------------------------------------

      final today = DateTime.now();

      final date =
          '${today.year}-'
          '${today.month.toString().padLeft(2, '0')}-'
          '${today.day.toString().padLeft(2, '0')}';

      // --------------------------------------------------------
      // FIND MOST USED APP
      // --------------------------------------------------------

      String? mostUsedApp;

      if (data.isNotEmpty) {
        final sortedData =
            List<dynamic>.from(data);

        sortedData.sort(
          (a, b) {
            final usageA =
                (a['usageTime'] as num?)
                        ?.toInt() ??
                    0;

            final usageB =
                (b['usageTime'] as num?)
                        ?.toInt() ??
                    0;

            return usageB.compareTo(usageA);
          },
        );

        final packageName =
            sortedData.first['packageName']
                ?.toString();

        mostUsedApp =
            getAppDisplayName(packageName);
      }

      // --------------------------------------------------------
      // SESSION COUNT
      // --------------------------------------------------------

      int sessionCount = 0;

      for (final event in events) {
        if (event['eventType'] == 'foreground') {
          sessionCount++;
        }
      }

      // --------------------------------------------------------
      // SAVE DAILY USAGE
      // --------------------------------------------------------

      await DatabaseService.saveDailyUsage(
        date: date,
        totalUsage: totalUsage,
        appSwitches: getAppSwitchCount(),
        sessionCount: sessionCount,
        mostUsedApp: mostUsedApp,
        mostReopenedApp:
            getMostReopenedApp(),
      );

      // --------------------------------------------------------
      // SAVE INDIVIDUAL APP USAGE
      // --------------------------------------------------------

      for (final app in data) {
        final packageName =
            app['packageName']?.toString();

        final usageTime =
            (app['usageTime'] as num?)
                    ?.toInt() ??
                0;

        if (packageName != null &&
            usageTime > 0) {
          await DatabaseService.saveAppUsage(
            date: date,
            packageName: packageName,
            usageTime: usageTime,
            sessionCount: 0,
          );
        }
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Usage data saved: '
            '${usageData.length} apps',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingUsage = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to get usage data: $e',
          ),
        ),
      );
    }
  }

  // ==========================================================
  // HOME SCREEN
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Digital Wellbeing',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: loadUsageData,
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // ------------------------------------------------
              // WELCOME
              // ------------------------------------------------

              const Text(
                'Good day!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Here is your digital wellbeing overview.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // SUMMARY CARDS
              // ------------------------------------------------

              Row(
                children: [

                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Screen Time',
                      value:
                          getTotalUsageTime(),
                      icon: Icons.phone_android,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Wellbeing',
                      value:
                          getWellbeingStatus(),
                      icon:
                          Icons.health_and_safety,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Focus',
                      value:
                          getFocusPercentage(),
                      icon: Icons.center_focus_strong,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // USAGE DATA BUTTON
              // ------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed:
                      isLoadingUsage
                          ? null
                          : loadUsageData,
                  icon: isLoadingUsage
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.refresh,
                        ),
                  label: Text(
                    isLoadingUsage
                        ? 'Getting Usage Data...'
                        : 'Get Usage Data',
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // SMARTPHONE USAGE
              // ------------------------------------------------

              const Text(
                'Smartphone Usage',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (usageData.isEmpty)
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        size: 45,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No usage data loaded yet.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

              if (usageData.isNotEmpty)
                ...usageData
                    .take(10)
                    .map(
                      (app) {
                        final packageName =
                            app['packageName']
                                ?.toString();

                        final appName =
                            getAppDisplayName(
                          packageName,
                        );

                        final usageTime =
                            (app['usageTime']
                                        as num?)
                                    ?.toInt() ??
                                0;

                        final minutes =
                            usageTime ~/
                                (1000 * 60);

                        final hours =
                            minutes ~/ 60;

                        final remainingMinutes =
                            minutes % 60;

                        String formattedTime;

                        if (hours > 0) {
                          formattedTime =
                              '${hours}h ${remainingMinutes}m';
                        } else {
                          formattedTime =
                              '${remainingMinutes}m';
                        }

                        return Card(
                          margin:
                              const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.apps,
                              ),
                            ),
                            title: Text(
                              appName,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              packageName ??
                                  'Unknown package',
                              style:
                                  const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: Text(
                              formattedTime,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // BEHAVIOUR ACTIVITY
              // ------------------------------------------------

              const Text(
                'Behaviour Activity',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [

                  Expanded(
                    child: _buildActivityCard(
                      icon: Icons.login,
                      title: 'Sessions',
                      value:
                          '${getSessionCount()}',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _buildActivityCard(
                      icon: Icons.swap_horiz,
                      title: 'App Switches',
                      value:
                          '${getAppSwitchCount()}',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(
                        Icons.repeat,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Text(
                        'Most Reopened App',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      getMostReopenedApp(),
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // TODAY'S INSIGHT
              // ------------------------------------------------

              const Text(
                "Today's Insight",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFEAF3FF),
                      Color(0xFFF6FAFF),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lightbulb,
                      color: Colors.orange,
                      size: 30,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Your wellbeing status is '
                      '${getWellbeingStatus()}.',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'You have used your smartphone '
                      '${getTotalUsageTime()} today '
                      'across ${usageData.length} apps.',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // INSIGHTS BUTTON
              // ------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const InsightsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.insights,
                  ),
                  label: const Text(
                    'View Insights',
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SUMMARY CARD
  // ==========================================================

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 28,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTIVITY CARD
  // ==========================================================

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.blue,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INSIGHTS SCREEN
// ============================================================

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              'Your Digital Wellbeing',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildInsightCard(
              icon: Icons.phone_android,
              title: 'Screen Time',
              value: '3h 42m',
              subtitle:
                  'Your daily smartphone usage',
            ),

            _buildInsightCard(
              icon: Icons.notifications,
              title: 'Notifications',
              value: '84',
              subtitle:
                  'Notifications received today',
            ),

            _buildInsightCard(
              icon: Icons.swap_horiz,
              title: 'App Switching',
              value: '42 times',
              subtitle:
                  'Number of app transitions',
            ),

            _buildInsightCard(
              icon:
                  Icons.health_and_safety,
              title: 'Digital Balance',
              value: 'Good',
              subtitle:
                  'Current wellbeing status',
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: Colors.blue,
                    size: 30,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'AI Behaviour Intelligence',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'As usage history grows, the system '
                    'will learn your normal smartphone '
                    'behaviour and provide personalized '
                    'insights.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Row(
        children: [

          CircleAvatar(
            child: Icon(icon),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Manasvi',
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Digital Wellbeing User',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            ListTile(
              leading:
                  const Icon(Icons.edit),
              title:
                  const Text('Edit Profile'),
              trailing:
                  const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const EditProfileScreen(),
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading:
                  const Icon(Icons.flag),
              title:
                  const Text('My Wellbeing Goal'),
              subtitle:
                  const Text(
                'Build healthier smartphone habits',
              ),
            ),

            const Divider(),

            ListTile(
              leading:
                  const Icon(Icons.logout),
              title:
                  const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EDIT PROFILE SCREEN
// ============================================================

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  final TextEditingController nameController =
      TextEditingController(
    text: 'Manasvi',
  );

  final TextEditingController goalController =
      TextEditingController(
    text:
        'Build healthier smartphone habits',
  );

  @override
  void dispose() {
    nameController.dispose();
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: goalController,
              decoration: InputDecoration(
                labelText:
                    'Wellbeing Goal',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Changes',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}