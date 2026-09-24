import 'package:flutter/material.dart';
import 'services/usage_service.dart';
import 'database/database_service.dart';
import 'package:fl_chart/fl_chart.dart';

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

  // ============================================================
  // LOGIN FUNCTION
  // ============================================================

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Email empty check
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
        ),
      );
      return;
    }

    // Gmail validation
    if (!email.toLowerCase().endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid Gmail address'),
        ),
      );
      return;
    }

    // Password empty check
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your password'),
        ),
      );
      return;
    }

    // Password validation
    if (password != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password failed. Please check your password.',
          ),
        ),
      );
      return;
    }

    // Successful login
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

              // Email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Password
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

              // Login Button
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

              // Forgot Password
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Register
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
// FORGOT PASSWORD SCREEN
// ============================================================

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  void sendResetLink() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password reset link sent to your email.',
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
          'Forgot Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Center(
                  child: Icon(
                    Icons.lock_reset,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 30),

                const Center(
                  child: Text(
                    'Reset your password',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 12),

                const Center(
                  child: Text(
                    'Enter your registered email address and we will send you a password reset link.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 35),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your registered email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex =
                        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                    if (!emailRegex.hasMatch(
                      value.trim(),
                    )) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed: sendResetLink,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Send Reset Link',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
      builder: (context) => const ProfileSetupScreen(),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
          'Create Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Start your personalized digital wellbeing journey.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // Name
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex =
                        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Create a password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // Confirm Password
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => register(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: const Icon(Icons.lock_reset_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                // Create Account
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Login
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ============================================================
// PRIVACY CONSENT SCREEN
// ============================================================

class PrivacyConsentScreen extends StatefulWidget {
  const PrivacyConsentScreen({super.key});

  @override
  State<PrivacyConsentScreen> createState() =>
      _PrivacyConsentScreenState();
}

class _PrivacyConsentScreenState
    extends State<PrivacyConsentScreen> {
  bool consentGiven = false;

  void continueToGoals() {
    if (!consentGiven) {
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
        builder: (context) => const ProfileSetupScreen(),
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
          'Privacy & Consent',
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
              const SizedBox(height: 15),

              // Privacy Icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.privacy_tip_outlined,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Your Privacy Matters',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Before we continue, please review how your data will be used.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // Data Usage Card
              _privacyItem(
                icon: Icons.phone_android_outlined,
                title: 'Screen & App Usage',
                description:
                    'The app may use screen-time and app usage information to understand your digital habits.',
              ),

              const SizedBox(height: 16),

              _privacyItem(
                icon: Icons.insights_outlined,
                title: 'Personalized Insights',
                description:
                    'Usage information can be analyzed to provide personalized digital wellbeing insights and recommendations.',
              ),

              const SizedBox(height: 16),

              _privacyItem(
                icon: Icons.lock_outline,
                title: 'Your Control',
                description:
                    'You can review and manage your wellbeing preferences from the app settings.',
              ),

              const SizedBox(height: 25),

              // Consent Checkbox
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: consentGiven,
                      onChanged: (value) {
                        setState(() {
                          consentGiven = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 11),
                        child: Text(
                          'I understand and agree to the use of my digital wellbeing data for providing personalized insights.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: continueToGoals,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Agree & Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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

  Widget _privacyItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 28,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.4,
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
// PROFILE SETUP / GOALS SCREEN
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
    if (selectedGoal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a wellbeing goal'),
        ),
      );
      return;
    }

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
                        selectedGoal = value!;
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
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

              const Text(
  'Weekly Screen Time',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 12),

Container(
  height: 250,
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: BarChart(
    BarChartData(
      maxY: 6,
      minY: 0,

      gridData: FlGridData(
        show: true,
      ),

      borderData: FlBorderData(
        show: false,
      ),

      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
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

              return Text(
                days[value.toInt()],
                style: const TextStyle(
                  fontSize: 11,
                ),
              );
            },
          ),
        ),
      ),

      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 2.5),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 3.2),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 4.0),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 2.8),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 3.7),
          ],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(toY: 4.5),
          ],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(toY: 3.5),
          ],
        ),
      ],
    ),
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
// INSIGHTS SCREEN - STEP 12
// DIGITAL WELLBEING SCORE
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Your Digital Wellbeing',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // OVERALL SCORE
            // =========================

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
                                Colors.grey.shade200,
                            color: Colors.blue,
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

            // =========================
            // DETAILED SCORES
            // =========================

            const Text(
              'Detailed Scores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildScoreCard(
              icon: Icons.center_focus_strong,
              title: 'Focus Score',
              score: focusScore,
            ),

            _buildScoreCard(
              icon: Icons.bedtime,
              title: 'Sleep Score',
              score: sleepScore,
            ),

            _buildScoreCard(
              icon: Icons.psychology,
              title: 'Behaviour Stability',
              score: behaviourScore,
            ),

            _buildScoreCard(
              icon: Icons.balance,
              title: 'Usage Balance',
              score: usageBalanceScore,
            ),

            const SizedBox(height: 20),

            // =========================
            // WHY SCORE CHANGED
            // =========================

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
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  _buildReason(
                    Icons.check_circle,
                    'Good focus behaviour today',
                    Colors.green,
                  ),

                  const SizedBox(height: 14),

                  _buildReason(
                    Icons.check_circle,
                    'App switching is under control',
                    Colors.green,
                  ),

                  const SizedBox(height: 14),

                  _buildReason(
                    Icons.warning_amber_rounded,
                    'Screen time can be reduced',
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // AI EXPLANATION
            // =========================

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
                    'The system analyses your smartphone '
                    'usage patterns to understand your '
                    'digital behaviour and provide '
                    'personalized wellbeing insights.',
                  ),
                ],
              ),
            ), // Container

// =========================
// PERSONALIZED RECOMMENDATIONS
// STEP 13
// =========================

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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Row(
        children: [
          Icon(
            Icons.lightbulb,
            color: Colors.orange,
            size: 28,
          ),

          SizedBox(width: 10),

          Text(
            'Recommended for you',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

      const SizedBox(height: 18),

      _buildRecommendation(
        context: context,
        icon: Icons.timer,
        title: 'Reduce Screen Time',
        description:
            'Try reducing your screen time by 30 minutes today.',
        buttonText: 'Set Goal',
      ),

      const Divider(height: 25),

      _buildRecommendation(
        context: context,
        icon: Icons.center_focus_strong,
        title: 'Start a Focus Session',
        description:
            'A focused 30-minute session can help improve your productivity.',
        buttonText: 'Start Focus',
      ),

      const Divider(height: 25),

      _buildRecommendation(
        context: context,
        icon: Icons.phone_disabled,
        title: 'Take a Short Break',
        description:
            'You have been using your phone continuously. Consider taking a 5-minute break.',
        buttonText: 'Take Break',
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
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    children: [
      const CircleAvatar(
        radius: 28,
        child: Icon(
          Icons.center_focus_strong,
          size: 28,
        ),
      ),

      const SizedBox(width: 16),

      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

const SizedBox(height: 20),

],
          
        ),
      ),
    );
  }

  // =========================
  // SCORE CARD
  // =========================
Widget _buildRecommendation({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String description,
  required String buttonText,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
          builder: (context) => const FocusModeScreen(),
        ),
      );
    } else if (buttonText == 'Take Break') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InterventionScreen(),
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
  Widget _buildScoreCard({
    required IconData icon,
    required String title,
    required int score,
  }) {
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

  // =========================
  // REASON
  // =========================

  Widget _buildReason(
    IconData icon,
    String text,
    Color color,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: color,
          size: 22,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// FOCUS MODE - STEP 14
// ============================================================

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

            // =========================
            // FOCUS SESSION CARD
            // =========================

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

                  // =========================
                  // DURATION
                  // =========================

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

                  // =========================
                  // START BUTTON
                  // =========================

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          sessionStarted = true;
                        });
                      },

                      icon: const Icon(
                        Icons.play_arrow,
                      ),

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

            // =========================
            // SESSION STATUS
            // =========================

            if (sessionStarted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(18),
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

                      icon: const Icon(
                        Icons.stop,
                      ),

                      label: const Text(
                        'End Session',
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            // =========================
            // FOCUS STATISTICS
            // =========================

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

  // =========================
  // DURATION BUTTON
  // =========================

  Widget _durationButton(int minutes) {
    final bool selected = selectedDuration == minutes;

    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedDuration = minutes;
          });
        },

        style: OutlinedButton.styleFrom(
          backgroundColor:
              selected ? Colors.blue : Colors.white,

          foregroundColor:
              selected ? Colors.white : Colors.blue,

          side: const BorderSide(
            color: Colors.blue,
          ),
        ),

        child: Text(
          '$minutes min',
        ),
      ),
    );
  }

  // =========================
  // STAT CARD
  // =========================

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
// INTERVENTION SCREEN - STEP 15
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

            // =========================
            // INTERVENTION ALERT
            // =========================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 38,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Potential Excessive Usage',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'You have been using your phone continuously '
                    'for longer than your recommended session.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // RECOMMENDED ACTION
            // =========================

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

                  // START FOCUS
                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          interventionAccepted = true;
                          interventionResponse = 'Focus Mode started';
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
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

                  // TAKE BREAK
                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          interventionAccepted = true;
                          interventionResponse = '5-minute break started';
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

                  // SNOOZE
                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: TextButton(
                      onPressed: () {
  setState(() {
    interventionAccepted = true;
    interventionResponse = 'Intervention snoozed';
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
                          
                    

                      child: const Text(
                        'Snooze',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // RESPONSE
            // =========================

            if (interventionAccepted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(18),
                ),

                child:  Row(
                  children: [

                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                       interventionResponse.isEmpty
    ? 'Your response has been recorded.'
    : interventionResponse,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            // =========================
            // WHY THIS INTERVENTION
            // =========================

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