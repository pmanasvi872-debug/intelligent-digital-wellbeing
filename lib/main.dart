import 'package:flutter/material.dart';
import 'services/usage_service.dart';
import 'database/database_service.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const DigitalWellbeingApp());
}

// ============================================================
// APP
// ============================================================

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
        useMaterial3: true,
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      _showMessage('Please enter your email');
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      _showMessage('Please enter a valid Gmail address');
      return;
    }

    if (password.isEmpty) {
      _showMessage('Please enter your password');
      return;
    }

    if (password != '123456') {
      _showMessage('Incorrect password. Use 123456 for demo login.');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFFE3F2FD),
                child: Icon(
                  Icons.phone_android,
                  size: 48,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Digital Wellbeing',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Build healthier smartphone habits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 45),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Demo password: 123456',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
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
// FORGOT PASSWORD
// ============================================================

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendResetLink() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset link sent to your email.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Icon(
              Icons.lock_reset,
              size: 70,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              'Reset your password',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Enter your registered email address.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: sendResetLink,
                child: const Text('Send Reset Link'),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REGISTER
// ============================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (name.isEmpty) {
      _message('Please enter your name');
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      _message('Please enter a valid Gmail address');
      return;
    }

    if (password.length < 6) {
      _message('Password must contain at least 6 characters');
      return;
    }

    if (password != confirm) {
      _message('Passwords do not match');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PrivacyConsentScreen(),
      ),
    );
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: const Icon(Icons.person_outline),
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
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: confirmPasswordController,
              obscureText: obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword =
                          !obscureConfirmPassword;
                    });
                  },
                ),
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
                onPressed: register,
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
// PRIVACY CONSENT
// ============================================================

class PrivacyConsentScreen extends StatefulWidget {
  const PrivacyConsentScreen({super.key});

  @override
  State<PrivacyConsentScreen> createState() =>
      _PrivacyConsentScreenState();
}

class _PrivacyConsentScreenState
    extends State<PrivacyConsentScreen> {
  bool consent = false;

  void continueSetup() {
    if (!consent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the privacy consent to continue.',
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileSetupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Consent'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.privacy_tip_outlined,
              size: 60,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              'Your Privacy Matters',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'The application analyses smartphone usage '
              'patterns to provide digital wellbeing insights.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            _privacyItem(
              Icons.phone_android,
              'Usage Data',
              'Screen time and application usage may be analysed.',
            ),

            _privacyItem(
              Icons.psychology,
              'Behaviour Analysis',
              'Usage patterns may be used to understand behaviour.',
            ),

            _privacyItem(
              Icons.security,
              'Data Protection',
              'Your wellbeing information should be handled securely.',
            ),

            const SizedBox(height: 15),

            CheckboxListTile(
              value: consent,
              onChanged: (value) {
                setState(() {
                  consent = value ?? false;
                });
              },
              title: const Text(
                'I understand and agree to the privacy policy.',
              ),
              controlAffinity:
                  ListTileControlAffinity.leading,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: continueSetup,
                child: const Text('Accept & Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _privacyItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}

// ============================================================
// PROFILE / GOALS SETUP
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

  String selectedGoal = '';

  final List<String> goals = [
    'Reduce screen time',
    'Reduce social media usage',
    'Improve focus',
    'Improve sleep',
    'Build healthier phone habits',
  ];

  @override
  void dispose() {
    goalController.dispose();
    super.dispose();
  }

  void continueSetup() {
    if (selectedGoal.isEmpty &&
        goalController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select or enter a wellbeing goal',
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Goals Setup',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set your wellbeing goal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Choose what you want to improve in your digital wellbeing journey.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Select your main goal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              ...goals.map(
                (goal) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedGoal == goal
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: selectedGoal == goal ? 2 : 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    value: goal,
                    groupValue: selectedGoal,
                    title: Text(
                      goal,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        selectedGoal = value ?? '';
                        goalController.clear();
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Or describe your own goal',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: goalController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText:
                      'Example: I want to use my phone less before sleeping',
                  prefixIcon: const Icon(
                    Icons.edit_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      selectedGoal = '';
                    });
                  }
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: continueSetup,
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
// HOME SCREEN
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingUsage = false;

  List<dynamic> usageData = [];
  List<dynamic> usageEvents = [];

  String getAppDisplayName(String? packageName) {
    if (packageName == null ||
        packageName.trim().isEmpty) {
      return 'Unknown App';
    }

    const appNames = {
      'com.example.intelligent_digital_wellbeing':
          'Digital Wellbeing',
      'com.android.launcher3': 'Android Launcher',
      'com.google.android.apps.nexuslauncher':
          'Pixel Launcher',
      'com.android.settings': 'Settings',
      'com.android.chrome': 'Chrome',
      'com.google.android.youtube': 'YouTube',
      'com.google.android.gm': 'Gmail',
      'com.google.android.apps.maps': 'Google Maps',
      'com.google.android.apps.photos': 'Google Photos',
      'com.google.android.googlequicksearchbox': 'Google',
      'com.google.android.apps.messaging': 'Google Messages',
      'com.google.android.vending': 'Google Play Store',
      'com.whatsapp': 'WhatsApp',
      'com.instagram.android': 'Instagram',
      'com.facebook.katana': 'Facebook',
      'com.spotify.music': 'Spotify',
      'com.microsoft.teams': 'Microsoft Teams',
      'com.linkedin.android': 'LinkedIn',
    };

    if (appNames.containsKey(packageName)) {
      return appNames[packageName]!;
    }

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

  String getTotalUsageTime() {
    int totalMilliseconds = 0;

    for (final app in usageData) {
      final usageTime = app['usageTime'];

      if (usageTime != null) {
        totalMilliseconds += (usageTime as num).toInt();
      }
    }

    final totalMinutes = totalMilliseconds ~/ (1000 * 60);
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }

    return '${minutes}m';
  }

  String getWellbeingStatus() {
    int totalMilliseconds = 0;

    for (final app in usageData) {
      final usageTime = app['usageTime'];

      if (usageTime != null) {
        totalMilliseconds += (usageTime as num).toInt();
      }
    }

    final totalHours =
        totalMilliseconds / (1000 * 60 * 60);

    if (totalHours < 3) {
      return 'Good';
    } else if (totalHours < 6) {
      return 'Moderate';
    }

    return 'Needs Attention';
  }

  String getFocusPercentage() {
    int totalMilliseconds = 0;

    for (final app in usageData) {
      final usageTime = app['usageTime'];

      if (usageTime != null) {
        totalMilliseconds += (usageTime as num).toInt();
      }
    }

    final totalHours =
        totalMilliseconds / (1000 * 60 * 60);

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

  int getSessionCount() {
    int count = 0;

    for (final event in usageEvents) {
      if (event['eventType'] == 'foreground') {
        count++;
      }
    }

    return count;
  }

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

      int totalUsage = 0;

      for (final app in data) {
        final usageTime = app['usageTime'];

        if (usageTime != null) {
          totalUsage += (usageTime as num).toInt();
        }
      }

      final today = DateTime.now();

      final date =
          '${today.year}-'
          '${today.month.toString().padLeft(2, '0')}-'
          '${today.day.toString().padLeft(2, '0')}';

      String? mostUsedApp;

      if (data.isNotEmpty) {
        final sortedData =
            List<dynamic>.from(data);

        sortedData.sort((a, b) {
          final usageA =
              (a['usageTime'] as num?)?.toInt() ?? 0;

          final usageB =
              (b['usageTime'] as num?)?.toInt() ?? 0;

          return usageB.compareTo(usageA);
        });

        mostUsedApp = getAppDisplayName(
          sortedData.first['packageName']?.toString(),
        );
      }

      final sessionCount = getSessionCount();

      await DatabaseService.saveDailyUsage(
        date: date,
        totalUsage: totalUsage,
        appSwitches: getAppSwitchCount(),
        sessionCount: sessionCount,
        mostUsedApp: mostUsedApp,
        mostReopenedApp: getMostReopenedApp(),
      );

      for (final app in data) {
        final packageName =
            app['packageName']?.toString();

        final usageTime =
            (app['usageTime'] as num?)?.toInt() ?? 0;

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
            'Usage data saved: ${usageData.length} apps',
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
                  builder: (_) => const ProfileScreen(),
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

              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Screen Time',
                      value: getTotalUsageTime(),
                      icon: Icons.phone_android,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Wellbeing',
                      value: getWellbeingStatus(),
                      icon: Icons.health_and_safety,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Focus',
                      value: getFocusPercentage(),
                      icon: Icons.center_focus_strong,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

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
                      : const Icon(Icons.refresh),
                  label: Text(
                    isLoadingUsage
                        ? 'Getting Usage Data...'
                        : 'Get Usage Data',
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Smartphone Usage',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (usageData.isEmpty)
                _emptyCard(
                  Icons.bar_chart,
                  'No usage data loaded yet.',
                ),

              if (usageData.isNotEmpty)
                ...usageData.take(10).map(
                  (app) {
                    final packageName =
                        app['packageName']?.toString();

                    final appName =
                        getAppDisplayName(packageName);

                    final usageTime =
                        (app['usageTime'] as num?)
                                ?.toInt() ??
                            0;

                    final minutes =
                        usageTime ~/ (1000 * 60);

                    final hours = minutes ~/ 60;
                    final remainingMinutes =
                        minutes % 60;

                    final formattedTime =
                        hours > 0
                            ? '${hours}h ${remainingMinutes}m'
                            : '${remainingMinutes}m';

                    return Card(
                      margin:
                          const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.apps),
                        ),
                        title: Text(
                          appName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          packageName ??
                              'Unknown package',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          formattedTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 25),

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

              _whiteCard(
                child: Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.repeat),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        'Most Reopened App',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      getMostReopenedApp(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

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
                padding: const EdgeInsets.all(20),
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
                        fontWeight: FontWeight.w600,
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

              const Text(
                'Weekly Screen Time',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _weeklyChart(),

              const SizedBox(height: 20),

              // NEW FEATURE NAVIGATION
              const Text(
                'AI & Wellbeing',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _navigationTile(
                context,
                Icons.psychology,
                'AI Behaviour',
                'Understand your current digital behaviour',
                const BehaviourScreen(),
              ),

              _navigationTile(
                context,
                Icons.warning_amber_rounded,
                'Behaviour Risk',
                'View your current behaviour risk',
                const BehaviourRiskScreen(),
              ),

              _navigationTile(
                context,
                Icons.person_search,
                'Personal Baseline',
                'See your normal usage pattern',
                const PersonalBaselineScreen(),
              ),

              _navigationTile(
                context,
                Icons.trending_up,
                'Behaviour Drift',
                'Compare current behaviour with baseline',
                const BehaviourDriftScreen(),
              ),

              _navigationTile(
                context,
                Icons.auto_graph,
                'AI Prediction',
                'View predicted screen time and risk',
                const PredictionScreen(),
              ),

              _navigationTile(
                context,
                Icons.info_outline,
                'AI Explanation',
                'Understand why AI generated the result',
                const ExplanationScreen(),
              ),

              const SizedBox(height: 10),

              _navigationTile(
                context,
                Icons.insights,
                'Complete Wellbeing',
                'Score, recommendations and trends',
                const InsightsScreen(),
              ),

              _navigationTile(
                context,
                Icons.bar_chart,
                'Weekly Report',
                'View your weekly intelligence report',
                const WeeklyReportScreen(),
              ),

              _navigationTile(
                context,
                Icons.flag,
                'Goal Progress',
                'Track progress towards your goals',
                const GoalProgressScreen(),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyCard(
    IconData icon,
    String text,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 45,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _whiteCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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

  Widget _weeklyChart() {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BarChart(
        BarChartData(
          maxY: 6,
          minY: 0,
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];

                  final index = value.toInt();

                  if (index < 0 ||
                      index >= days.length) {
                    return const SizedBox();
                  }

                  return Text(
                    days[index],
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            _bar(0, 2.5),
            _bar(1, 3.2),
            _bar(2, 4.0),
            _bar(3, 2.8),
            _bar(4, 3.7),
            _bar(5, 4.5),
            _bar(6, 3.5),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _bar(
    int x,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 18,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _navigationTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget screen,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing:
            const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// AI BEHAVIOUR SCREEN
// ============================================================

class BehaviourScreen extends StatelessWidget {
  const BehaviourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Behaviour'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Behaviour',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'AI analyses your smartphone usage patterns '
              'to identify your current behaviour.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _behaviourCard(
              context,
              'Focused',
              'High concentration with controlled app switching.',
              Icons.center_focus_strong,
            ),

            _behaviourCard(
              context,
              'Balanced',
              'Healthy balance between different smartphone activities.',
              Icons.balance,
            ),

            _behaviourCard(
              context,
              'Distracted',
              'Frequent switching between applications.',
              Icons.swap_horiz,
            ),

            _behaviourCard(
              context,
              'Excessive',
              'High overall smartphone usage detected.',
              Icons.warning_amber_rounded,
            ),

            _behaviourCard(
              context,
              'Potential Doomscrolling',
              'Long continuous social or entertainment usage.',
              Icons.vertical_align_bottom,
            ),

            const SizedBox(height: 15),

            _infoCard(
              'AI Behaviour Intelligence',
              'The behaviour classification is based on usage '
              'duration, sessions, app switching and usage patterns.',
              Icons.psychology,
            ),
          ],
        ),
      ),
    );
  }

  Widget _behaviourCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.all(14),
        leading: CircleAvatar(
          radius: 27,
          backgroundColor: Colors.blue.shade50,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding:
              const EdgeInsets.only(top: 6),
          child: Text(description),
        ),
      ),
    );
  }

  Widget _infoCard(
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

// ============================================================
// BEHAVIOUR RISK
// ============================================================

class BehaviourRiskScreen extends StatelessWidget {
  const BehaviourRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const risk = 42;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Behaviour Risk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Behaviour Risk Analysis',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'The system estimates your current digital '
              'behaviour risk from usage patterns.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Current Risk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: risk / 100,
                          strokeWidth: 14,
                          backgroundColor:
                              Colors.grey.shade200,
                        ),
                        Text(
                          '$risk%',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Moderate',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _riskItem(
              'Screen Time',
              'Moderate',
              Icons.phone_android,
            ),

            _riskItem(
              'App Switching',
              'Low',
              Icons.swap_horiz,
            ),

            _riskItem(
              'Continuous Usage',
              'Moderate',
              Icons.timer,
            ),

            _riskItem(
              'Night Usage',
              'Low',
              Icons.nightlight,
            ),

            const SizedBox(height: 20),

            _info(
              'Risk Interpretation',
              'Low risk indicates controlled usage. Moderate '
              'risk indicates patterns that may require attention. '
              'High risk indicates stronger unhealthy usage patterns.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _riskItem(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _info(
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

// ============================================================
// PERSONAL BASELINE
// ============================================================

class PersonalBaselineScreen extends StatelessWidget {
  const PersonalBaselineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Baseline'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Personal Baseline',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Your baseline represents your normal smartphone '
              'usage pattern learned over time.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _baselineCard(
              'Average Screen Time',
              '4h 12m',
              Icons.phone_android,
            ),

            _baselineCard(
              'Average Sessions',
              '38',
              Icons.login,
            ),

            _baselineCard(
              'Average App Switches',
              '72',
              Icons.swap_horiz,
            ),

            _baselineCard(
              'Typical Night Usage',
              '32 min',
              Icons.nightlight,
            ),

            const SizedBox(height: 20),

            _informationCard(
              'How the baseline works',
              'The system observes your historical usage and '
              'builds a personal pattern instead of relying only '
              'on a fixed population average.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _baselineCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard(
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.person_search,
            color: Colors.blue,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

// ============================================================
// BEHAVIOUR DRIFT
// ============================================================

class BehaviourDriftScreen extends StatelessWidget {
  const BehaviourDriftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Behaviour Drift'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Behaviour Drift Detection',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Compare your current behaviour with your personal baseline.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _comparison(
              'Screen Time',
              '4h 12m',
              '5h 05m',
              '+53 min',
              Icons.phone_android,
            ),

            _comparison(
              'App Switching',
              '72',
              '91',
              '+19',
              Icons.swap_horiz,
            ),

            _comparison(
              'Night Usage',
              '32 min',
              '45 min',
              '+13 min',
              Icons.nightlight,
            ),

            _comparison(
              'Focus Time',
              '2h 10m',
              '2h 35m',
              '+25 min',
              Icons.center_focus_strong,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.orange,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Behaviour Drift Detected',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your current usage is higher than your '
                    'normal personal pattern in some areas.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _comparison(
    String title,
    String baseline,
    String current,
    String difference,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Icon(icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  difference,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Baseline\n$baseline',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: Text(
                    'Current\n$current',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PREDICTION
// ============================================================

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Prediction'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Prediction',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Predicted usage and behaviour risk based on recent patterns.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _predictionCard(
              'Predicted Screen Time',
              '5h 18m',
              'Estimated screen time for today',
              Icons.access_time,
            ),

            _predictionCard(
              'Predicted Behaviour',
              'Balanced',
              'Expected behaviour based on recent usage',
              Icons.psychology,
            ),

            _predictionCard(
              'Predicted Risk',
              'Moderate',
              'Expected behaviour risk',
              Icons.warning_amber_rounded,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_graph,
                    color: Colors.blue,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Prediction Insight',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Recent screen-time and app-switching patterns '
                    'suggest that usage may increase if the current '
                    'pattern continues.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _predictionCard(
    String title,
    String value,
    String description,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade50,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EXPLANATION
// ============================================================

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Explanation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Why did AI give this result?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'The following usage factors contribute to the AI analysis.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _explanationItem(
              Icons.phone_android,
              'Screen Time',
              'Your total screen time contributes to the behaviour assessment.',
            ),

            _explanationItem(
              Icons.swap_horiz,
              'App Switching',
              'Frequent switching may indicate distraction.',
            ),

            _explanationItem(
              Icons.timer,
              'Session Duration',
              'Long continuous sessions can increase usage risk.',
            ),

            _explanationItem(
              Icons.nightlight,
              'Night Usage',
              'Late-night usage is considered when evaluating wellbeing.',
            ),

            _explanationItem(
              Icons.person_search,
              'Personal Baseline',
              'Current behaviour is compared with your normal pattern.',
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'This explanation helps make the AI result understandable '
                'by showing the major factors considered during analysis.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _explanationItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INSIGHTS / DIGITAL WELLBEING SCORE
// ============================================================

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int overallScore = 78;
    const int focusScore = 82;
    const int sleepScore = 75;
    const int behaviourScore = 80;
    const int usageBalanceScore = 76;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Wellbeing'),
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

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Digital Wellbeing Score',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: overallScore / 100,
                            strokeWidth: 14,
                            backgroundColor:
                                Color(0xFFE5E7EB),
                          ),
                        ),
                        Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: const [
                            Text(
                              '$overallScore',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              '/ 100',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Good',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Your digital behaviour is currently balanced.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Detailed Scores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _scoreCard(
              Icons.center_focus_strong,
              'Focus Score',
              focusScore,
            ),

            _scoreCard(
              Icons.bedtime,
              'Sleep Score',
              sleepScore,
            ),

            _scoreCard(
              Icons.psychology,
              'Behaviour Stability',
              behaviourScore,
            ),

            _scoreCard(
              Icons.balance,
              'Usage Balance',
              usageBalanceScore,
            ),

            const SizedBox(height: 20),

            const Text(
              'Why your score changed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _reason(
                    Icons.check_circle,
                    'Good focus behaviour today',
                  ),
                  const SizedBox(height: 14),
                  _reason(
                    Icons.check_circle,
                    'App switching is under control',
                  ),
                  const SizedBox(height: 14),
                  _reason(
                    Icons.warning_amber_rounded,
                    'Screen time can be reduced',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The system analyses your smartphone usage '
                    'patterns to understand your digital behaviour '
                    'and provide personalized wellbeing insights.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Personalized Recommendations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _recommendation(
                    context,
                    Icons.timer,
                    'Reduce Screen Time',
                    'Try reducing your screen time by 30 minutes today.',
                    'Set Goal',
                  ),

                  const Divider(height: 25),

                  _recommendation(
                    context,
                    Icons.center_focus_strong,
                    'Start a Focus Session',
                    'A focused 30-minute session can help improve productivity.',
                    'Start Focus',
                  ),

                  const Divider(height: 25),

                  _recommendation(
                    context,
                    Icons.phone_disabled,
                    'Take a Short Break',
                    'You have been using your phone continuously. Consider taking a 5-minute break.',
                    'Take Break',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Focus Trend',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(
                      Icons.center_focus_strong,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Focus Score',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '82 / 100',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your focus is improving this week.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _actionTile(
              context,
              Icons.center_focus_strong,
              'Focus Mode',
              const FocusModeScreen(),
            ),

            _actionTile(
              context,
              Icons.notifications_active,
              'Smart Intervention',
              const InterventionScreen(),
            ),

            _actionTile(
              context,
              Icons.bar_chart,
              'Weekly Report',
              const WeeklyReportScreen(),
            ),

            _actionTile(
              context,
              Icons.flag,
              'Goal Progress',
              const GoalProgressScreen(),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _scoreCard(
    IconData icon,
    String title,
    int score,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$score / 100',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reason(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: icon == Icons.check_circle
              ? Colors.green
              : Colors.orange,
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }

  Widget _recommendation(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    String buttonText,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  if (buttonText == 'Start Focus') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const FocusModeScreen(),
                      ),
                    );
                  } else if (buttonText == 'Take Break') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const InterventionScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Goal setup action selected.',
                        ),
                      ),
                    );
                  }
                },
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionTile(
    BuildContext context,
    IconData icon,
    String title,
    Widget screen,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing:
            const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// FOCUS SCORE
// ============================================================

class FocusScoreScreen extends StatelessWidget {
  const FocusScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const score = 82;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Score'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _largeScoreCard(
              'Focus Score',
              score,
              Icons.center_focus_strong,
            ),

            const SizedBox(height: 20),

            _metric(
              'Focus Sessions',
              '2 sessions',
              Icons.timer,
            ),

            _metric(
              'Focus Time',
              '45 minutes',
              Icons.access_time,
            ),

            _metric(
              'Distraction Level',
              'Low',
              Icons.notifications_off,
            ),

            const SizedBox(height: 20),

            _infoBox(
              'Focus Insight',
              'Your focused sessions are contributing positively '
              'to your overall digital wellbeing score.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BEHAVIOUR STABILITY
// ============================================================

class BehaviourStabilityScreen extends StatelessWidget {
  const BehaviourStabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const score = 80;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Behaviour Stability'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _largeScoreCard(
              'Behaviour Stability',
              score,
              Icons.psychology,
            ),

            const SizedBox(height: 20),

            _metric(
              'Baseline Consistency',
              'Good',
              Icons.timeline,
            ),

            _metric(
              'Usage Pattern',
              'Stable',
              Icons.pattern,
            ),

            _metric(
              'Behaviour Drift',
              'Moderate',
              Icons.trending_up,
            ),

            const SizedBox(height: 20),

            _infoBox(
              'Stability Insight',
              'Your overall smartphone behaviour remains reasonably '
              'consistent with your personal baseline.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FOCUS MODE
// ============================================================

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() =>
      _FocusModeScreenState();
}

class _FocusModeScreenState
    extends State<FocusModeScreen> {
  int selectedDuration = 30;
  bool sessionStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Mode'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Smart Focus Mode',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Create a focused session and reduce distractions.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Color(0xFFE3F2FD),
                    child: Icon(
                      Icons.center_focus_strong,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Focus Session',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Choose how long you want to focus.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Duration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      _durationButton(15),
                      const SizedBox(width: 10),
                      _durationButton(30),
                      const SizedBox(width: 10),
                      _durationButton(60),
                    ],
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          sessionStarted = true;
                        });
                      },
                      icon:
                          const Icon(Icons.play_arrow),
                      label: const Text(
                        'Start Focus',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            if (sessionStarted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 35,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Focus Session Active',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '$selectedDuration minutes',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 15),

                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          sessionStarted = false;
                        });
                      },
                      icon: const Icon(Icons.stop),
                      label:
                          const Text('End Session'),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            const Text(
              'Focus Statistics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    Icons.event_available,
                    'Sessions Today',
                    '2',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    Icons.timer,
                    'Focus Time',
                    '45 min',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _durationButton(int minutes) {
    final selected =
        selectedDuration == minutes;

    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedDuration = minutes;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              selected
                  ? Colors.blue
                  : Colors.white,
          foregroundColor:
              selected
                  ? Colors.white
                  : Colors.blue,
          side: const BorderSide(
            color: Colors.blue,
          ),
        ),
        child: Text('$minutes min'),
      ),
    );
  }

  Widget _statCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INTERVENTION
// ============================================================

class InterventionScreen extends StatefulWidget {
  const InterventionScreen({super.key});

  @override
  State<InterventionScreen> createState() =>
      _InterventionScreenState();
}

class _InterventionScreenState
    extends State<InterventionScreen> {
  bool interventionAccepted = false;
  String interventionResponse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Intervention'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Personalized Intervention',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'A small action can help you maintain a healthy digital routine.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 38,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Potential Excessive Usage',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You have been using your phone continuously '
                    'for longer than your recommended session.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recommended Action',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Take a 5-minute break or start a Focus Session '
                    'to reduce distractions.',
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          interventionAccepted = true;
                          interventionResponse =
                              'Focus Mode started';
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const FocusModeScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.center_focus_strong,
                      ),
                      label: const Text(
                        'Start Focus Mode',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          interventionAccepted = true;
                          interventionResponse =
                              '5-minute break started';
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              '5-minute break started.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.free_breakfast,
                      ),
                      label: const Text(
                        'Take a 5-Minute Break',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          interventionAccepted = true;
                          interventionResponse =
                              'Intervention snoozed';
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Intervention snoozed.',
                            ),
                          ),
                        );
                      },
                      child:
                          const Text('Snooze'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (interventionAccepted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        interventionResponse.isEmpty
                            ? 'Your response has been recorded.'
                            : interventionResponse,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            const Text(
              'Why this intervention?',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'The system uses your usage behaviour, '
                'personal baseline and risk level to select '
                'a suitable intervention.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TREND SCREEN
// ============================================================

class TrendScreen extends StatelessWidget {
  const TrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usage Trends'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Usage Trends',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Daily screen-time trend for the current week.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: BarChart(
                BarChartData(
                  maxY: 7,
                  borderData:
                      FlBorderData(show: false),
                  gridData:
                      const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: false,
                      ),
                    ),
                    leftTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                      ),
                    ),
                    bottomTitles:
                        AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: true,
                        getTitlesWidget:
                            (value, meta) {
                          const days = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun',
                          ];

                          final index =
                              value.toInt();

                          if (index < 0 ||
                              index >=
                                  days.length) {
                            return const SizedBox();
                          }

                          return Text(
                            days[index],
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    _bar(0, 3.1),
                    _bar(1, 4.2),
                    _bar(2, 3.7),
                    _bar(3, 5.0),
                    _bar(4, 4.1),
                    _bar(5, 5.4),
                    _bar(6, 4.5),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Trend Insight',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _infoBox(
              'Weekly Pattern',
              'Your usage varies throughout the week. '
              'The system can use these patterns to provide '
              'personalized recommendations.',
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _bar(
    int x,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 20,
          borderRadius:
              BorderRadius.circular(4),
        ),
      ],
    );
  }
}

// ============================================================
// WEEKLY REPORT
// ============================================================

class WeeklyReportScreen extends StatelessWidget {
  const WeeklyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Intelligence Report',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'A summary of your digital wellbeing activity.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _reportCard(
              'Average Screen Time',
              '4h 18m',
              Icons.phone_android,
            ),

            _reportCard(
              'Average Focus Time',
              '2h 10m',
              Icons.center_focus_strong,
            ),

            _reportCard(
              'Average Wellbeing Score',
              '78 / 100',
              Icons.health_and_safety,
            ),

            _reportCard(
              'Behaviour',
              'Balanced',
              Icons.psychology,
            ),

            const SizedBox(height: 25),

            const Text(
              'Weekly Trend',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              height: 250,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: BarChart(
                BarChartData(
                  maxY: 7,
                  borderData:
                      FlBorderData(show: false),
                  gridData:
                      const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: false,
                      ),
                    ),
                    leftTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                      ),
                    ),
                    bottomTitles:
                        AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles: true,
                        getTitlesWidget:
                            (value, meta) {
                          const days = [
                            'M',
                            'T',
                            'W',
                            'T',
                            'F',
                            'S',
                            'S',
                          ];

                          final i =
                              value.toInt();

                          if (i < 0 ||
                              i >=
                                  days.length) {
                            return const SizedBox();
                          }

                          return Text(
                            days[i],
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    _bar(0, 3.0),
                    _bar(1, 4.0),
                    _bar(2, 3.5),
                    _bar(3, 4.8),
                    _bar(4, 4.0),
                    _bar(5, 5.0),
                    _bar(6, 4.2),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            _infoBox(
              'Weekly Intelligence',
              'Your overall wellbeing score remained stable this week. '
              'Focus behaviour was positive while screen time '
              'can still be reduced.',
            ),

            const SizedBox(height: 20),

            _infoBox(
              'Personalized Recommendation',
              'Try a 30-minute Focus Session during your most productive '
              'period and reduce continuous entertainment usage.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                Colors.blue.shade50,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _bar(
    int x,
    double value,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 18,
          borderRadius:
              BorderRadius.circular(4),
        ),
      ],
    );
  }
}

// ============================================================
// GOAL PROGRESS
// ============================================================

class GoalProgressScreen extends StatelessWidget {
  const GoalProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Progress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Goal Progress',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Track your progress towards healthier smartphone habits.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            _goalItem(
              'Screen-Time Goal',
              'Target: 4h/day',
              'Current: 4h 18m',
              0.82,
              Icons.timer,
            ),

            _goalItem(
              'Social Media Limit',
              'Target: 60 min/day',
              'Current: 72 min',
              0.70,
              Icons.people,
            ),

            _goalItem(
              'Focus Target',
              'Target: 2h/day',
              'Current: 2h 10m',
              0.90,
              Icons.center_focus_strong,
            ),

            _goalItem(
              'Sleep Schedule',
              'Target: Before 11 PM',
              'Current: 11:20 PM',
              0.75,
              Icons.bedtime,
            ),

            const SizedBox(height: 20),

            _infoBox(
              'Goal Insight',
              'Your progress is tracked using your smartphone '
              'usage patterns and wellbeing activity.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _goalItem(
    String title,
    String target,
    String current,
    double progress,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Colors.blue.shade50,
                child: Icon(
                  icon,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius:
                BorderRadius.circular(10),
          ),

          const SizedBox(height: 12),

          Text(
            target,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            current,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE
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
                fontWeight: FontWeight.bold,
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
                    builder: (_) =>
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
                    builder: (_) =>
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
// EDIT PROFILE
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

// ============================================================
// SHARED UI HELPERS
// ============================================================

Widget _largeScoreCard(
  String title,
  int score,
  IconData icon,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.blue.shade50,
          child: Icon(
            icon,
            size: 35,
            color: Colors.blue,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 13,
                backgroundColor:
                    Colors.grey.shade200,
              ),
              Text(
                '$score',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          '/ 100',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

Widget _metric(
  String title,
  String value,
  IconData icon,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor:
              Colors.blue.shade50,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _infoBox(
  String title,
  String description,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.lightbulb,
          color: Colors.blue,
          size: 30,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(description),
      ],
    ),
  );
}