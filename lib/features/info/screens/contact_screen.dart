import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_inputs.dart';
import '../../../../shared/widgets/app_buttons.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedSubject = 'General Inquiry';

  final List<String> _subjects = [
    'General Inquiry',
    'Admissions',
    'Tuition Fees',
    'Academic Support',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      'Contact Us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero
                    Text(
                      'Get in Touch',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? Colors.blue.shade100
                            : const Color(0xFF0A2540),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'We are here to help you with any inquiries.',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? Colors.grey.shade400
                            : const Color(0xFF617489),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Quick Action Cards
                    Row(
                      children: [
                        _buildContactCard(
                          context,
                          icon: Icons.location_on,
                          title: 'Address',
                          subtitle: 'Jamuna Cantonment',
                        ),
                        const SizedBox(width: 12),
                        _buildContactCard(
                          context,
                          icon: Icons.call,
                          title: 'Phone',
                          subtitle: '+880 1712-345678',
                        ),
                        const SizedBox(width: 12),
                        _buildContactCard(
                          context,
                          icon: Icons.mail,
                          title: 'Email',
                          subtitle: 'info@jacpsc.edu.bd',
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Inquiry Form
                    Text(
                      'Have a Question?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0A2540),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill out the form below and our admin team will get back to you within 24 hours.',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? Colors.grey.shade400
                            : const Color(0xFF617489),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    AppTextField(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Email or Student ID',
                      hint: 'e.g. 12345 or email@example.com',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subject',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AppDropdown<String>(
                          value: _selectedSubject,
                          items: _subjects
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _selectedSubject = val!),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Message',
                      hint: 'How can we help you?',
                      controller: _messageController,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    AppButton(label: 'Send Message', onPressed: () {}),

                    const SizedBox(height: 32),

                    // Map Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Find us on Campus',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Open Maps'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDebb8afEGOLeXYt5jhGVTGn_ZhfQKnCQ-c9ZDq-DR_B6cwSFt2UU5LGUnzoiHXcsqbFisVtMY90jVePFWoOi9hstgFzrw6yYKicTkMmuLIM5vEK2pfy8bm9k0MpZjFi67NtWQYGE1H0p6oQiW3b8qojH5CkXPWFdFOwkqkkGMlGjGURV9f8gejfBO2grupWdl1PoJ4dtIA1yyoJKLbyj_XxBokMmkJjMbQ8tF5JULUM8xo9Jvkh8k-l8hlJS-wgcHJLblcA4F9oWzY',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 36,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'JACPSC',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A2540),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        '© 2023 Jamuna Cantonment Public School & College.',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade500
                              : const Color(0xFF9AA6B2),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : const Color(0xFFDBE0E6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.grey.shade400 : const Color(0xFF617489),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
