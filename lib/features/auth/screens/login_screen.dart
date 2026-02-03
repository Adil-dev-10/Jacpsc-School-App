import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../services/auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  String _userType = 'student'; // student, teacher, staff
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.login(
      _idController.text,
      _passwordController.text,
      _userType,
    );

    // Error handling
    final authState = ref.read(authProvider);
    if (authState.error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authState.error!), backgroundColor: Colors.red),
      );
    }
    // Success redirect handled by Router
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: Stack(
        children: [
          // Background Blobs
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: isDark ? Colors.white : AppColors.primary,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.white10
                              : Colors.black.withValues(alpha: 0.05),
                        ),
                      ),
                      Text(
                        'JACPSC Portal v2.4',
                        style: TextStyle(
                          color: isDark ? Colors.grey : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Logo Section
                  Container(
                    width: 96,
                    height: 96,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    // Use Icon placeholder for now or image asset if setup
                    child: const Icon(
                      Icons.school,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ).animate().scale(
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'JACPSC',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: isDark ? Colors.white : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),

                  Text(
                    'Jamuna Cantonment Public School & College',
                    style: TextStyle(
                      color: isDark ? Colors.grey : Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 40),

                  // Welcome Text
                  Text(
                    'Welcome Back',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.primary,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  Text(
                    'Please log in to continue',
                    style: TextStyle(
                      color: isDark ? Colors.grey : Colors.grey.shade500,
                    ),
                  ).animate().fadeIn(delay: 500.ms),

                  const SizedBox(height: 32),

                  // Segmented Control
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _buildSegment('student', 'Student'),
                        _buildSegment('teacher', 'Teacher'),
                        _buildSegment('staff', 'Staff'),
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms).moveY(begin: 20, end: 0),

                  const SizedBox(height: 24),

                  // Form
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Student ID', isDark),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _idController,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: _inputDecoration(
                          hint: 'Enter your ID',
                          icon: Icons.badge_outlined,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLabel('Password', isDark),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: _inputDecoration(
                          hint: '••••••••',
                          icon: Icons.lock_outline,
                          isDark: isDark,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 700.ms),

                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: authState.isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        shadowColor: AppColors.primary.withValues(alpha: 0.4),
                      ),
                      child: authState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).moveY(begin: 20, end: 0),

                  const SizedBox(height: 16),

                  // Face ID Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.face, size: 24),
                      label: const Text('Login with Face ID'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark
                            ? Colors.white
                            : AppColors.primary,
                        side: BorderSide.none,
                        backgroundColor: isDark
                            ? Colors.white10
                            : AppColors.primary.withValues(alpha: 0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 900.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(String value, String label) {
    final isSelected = _userType == value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _userType = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.primary : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? (isDark ? Colors.white : AppColors.primary)
                  : (isDark ? Colors.grey : Colors.grey.shade600),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: isDark ? Colors.grey.shade300 : AppColors.primary,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required bool isDark,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey.shade400),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark ? Colors.white10 : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
    );
  }
}
