import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class FeatureInProgressScreen extends StatelessWidget {
  final String title;

  const FeatureInProgressScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80,
              color: AppColors.primary.withValues(alpha: 0.5),
            ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 24),
            Text(
              'Under Construction',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),
            const SizedBox(height: 8),
            Text(
              'We are currently building this feature.\nStay tuned!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.grey : Colors.grey.shade600,
              ),
            ).animate().fadeIn(delay: 400.ms).moveY(begin: 10, end: 0),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
