import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../services/auth_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Artificial delay for splash animation
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final authState = ref.read(authProvider);

    // If not authenticated (or initial load), check logic in router or redirect here
    // For now, simpler to verify here or just let Router redirect.
    // However, since Splash is the initial route, we can manually direct.

    if (authState.isAuthenticated) {
      context.go('/app/home');
    } else {
      context.go('/landing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Elements matching prototype
          Positioned(
            top: -128,
            right: -128,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                color: Colors.blue.shade50.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ).animate().fadeIn(duration: 1.seconds),
          ),
          Positioned(
            bottom: -128,
            left: -128,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ).animate().fadeIn(duration: 1.seconds, delay: 300.ms),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Circle
                  Container(
                    width: 192,
                    height: 192,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0xFF1E40AF), Color(0xFF002147)],
                        center: Alignment.topLeft,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 4,
                      ),
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 96,
                      color: Colors.white,
                    ),
                  ).animate().scale(
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                  ),

                  const SizedBox(height: 48),

                  // Title
                  Text(
                    'Jamuna Cantonment',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                  ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
                  Text(
                    'Public School & College',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      height: 1.15,
                    ),
                  ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),

                  const SizedBox(height: 16),

                  // Separator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 32,
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'JACPSC',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.primary.withValues(alpha: 0.6),
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 32,
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ],
                  ).animate().fadeIn(delay: 700.ms),
                ],
              ),
            ),
          ),

          // Bottom Loading Bar
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 140,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Stack(
                  children: [
                    Container(
                          width: 56, // 40%
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .moveX(
                          begin: -56,
                          end: 140,
                          duration: 2.seconds,
                          curve: Curves.easeInOut,
                        ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 1.seconds),
          ),
        ],
      ),
    );
  }
}
