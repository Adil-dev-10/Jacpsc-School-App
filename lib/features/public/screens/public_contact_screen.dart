import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class PublicContactScreen extends StatelessWidget {
  const PublicContactScreen({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF101822)
          : const Color(0xFFF6F7F8),
      appBar: AppBar(
        title: const Text('Contact Us'),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF101822) : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.textMainLight,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0a2540),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'We are here to help you with any inquiries.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),

            // Contact Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildContactCard(
                    context,
                    Icons.location_on,
                    "Address",
                    "Jamuna Cantonment, Bhuapur",
                    () => _launchUrl(
                      "https://maps.google.com/?q=Jamuna+Cantonment+Public+School",
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    Icons.call,
                    "Phone",
                    "+880 1712-345678",
                    () => _launchUrl("tel:+8801712345678"),
                  ),
                  const SizedBox(height: 12),
                  _buildContactCard(
                    context,
                    Icons.mail,
                    "Email",
                    "info@jacpsc.edu.bd",
                    () => _launchUrl("mailto:info@jacpsc.edu.bd"),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),

            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Have a Question?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0a2540),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fill out the form below and our admin team will get back to you within 24 hours.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(context, "Full Name", "Enter your full name"),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    "Email or Student ID",
                    "e.g. 12345 or email@example.com",
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(context, "Subject", [
                    "General Inquiry",
                    "Admissions",
                    "Tuition Fees",
                    "Academic Support",
                  ]),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    "Message",
                    "How can we help you?",
                    maxLines: 4,
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Message sent successfully!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Send Message',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Map Preview
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Find us on Campus',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _launchUrl(
                          "https://maps.google.com/?q=Jamuna+Cantonment+Public+School",
                        ),
                        child: const Text('Open Maps'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[300]!),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuDebb8afEGOLeXYt5jhGVTGn_ZhfQKnCQ-c9ZDq-DR_B6cwSFt2UU5LGUnzoiHXcsqbFisVtMY90jVePFWoOi9hstgFzrw6yYKicTkMmuLIM5vEK2pfy8bm9k0MpZjFi67NtWQYGE1H0p6oQiW3b8qojH5CkXPWFdFOwkqkkGMlGjGURV9f8gejfBO2grupWdl1PoJ4dtIA1yyoJKLbyj_XxBokMmkJjMbQ8tF5JULUM8xo9Jvkh8k-l8hlJS-wgcHJLblcA4F9oWzY",
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
                            size: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'JACPSC',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  '© 2023 Jamuna Cantonment Public School & College.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1a2634) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.grey[800]! : const Color(0xFFdbe0e6),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String hint, {
    int maxLines = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
            filled: true,
            fillColor: isDark ? const Color(0xFF1a2634) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context,
    String label,
    List<String> items,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {},
          value: items.first,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? const Color(0xFF1a2634) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
