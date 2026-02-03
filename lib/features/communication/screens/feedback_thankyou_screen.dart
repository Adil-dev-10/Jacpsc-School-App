import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class FeedbackThankYouScreen extends StatelessWidget {
  const FeedbackThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : AppColors.primary,
          ),
          onPressed: () => context.go('/app/home'),
        ),
        title: Text(
          'Feedback',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Checkmark Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 32),

            // Thank You Title
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            // Message
            Text(
              'Your feedback has been submitted successfully. We appreciate your input in making JACPSC better.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),

            const Spacer(flex: 2),

            // Back to Home Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/app/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const Spacer(flex: 1),

            // Footer
            Text(
              'Made with Adil-Dev',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
