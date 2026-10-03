import 'package:flutter/material.dart';

class ExplanationScreen extends StatelessWidget {
  const ExplanationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explanation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Why this prediction?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Here are the main behaviour patterns that contributed '
              'to your prediction.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // Prediction summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFF6C63FF),
                    size: 32,
                  ),

                  SizedBox(height: 14),

                  Text(
                    'Potential Doomscrolling',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4B44B8),
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Your recent activity contains several patterns '
                    'associated with increased passive screen usage.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            const Text(
              'Key factors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 14),

            _factorCard(
              Icons.access_time_rounded,
              'Increased screen time',
              'Your recent screen time is above your personal baseline.',
            ),

            const SizedBox(height: 14),

            _factorCard(
              Icons.phone_android_rounded,
              'Frequent app usage',
              'Repeated app sessions may indicate longer periods '
                  'of continuous device use.',
            ),

            const SizedBox(height: 14),

            _factorCard(
              Icons.nightlight_round,
              'Late-night activity',
              'Some activity was recorded during your usual sleep period.',
            ),

            const SizedBox(height: 14),

            _factorCard(
              Icons.trending_up_rounded,
              'Behaviour drift',
              'Your recent behaviour has moved away from your '
                  'personal baseline.',
            ),

            const SizedBox(height: 26),

            // Explanation / interpretation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7FA),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF6C63FF),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'This prediction is an indication based on '
                      'observed behaviour patterns. It is not a diagnosis '
                      'or a fixed outcome.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Continue to Step 12
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  // We will connect this to Step 12 next.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Step 12 will be connected next.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Prediction'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _factorCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE9EAF0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEBFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6C63FF),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
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