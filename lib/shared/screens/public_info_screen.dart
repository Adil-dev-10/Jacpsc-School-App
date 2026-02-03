import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart'; // Added url_launcher
import '../../core/theme/app_colors.dart';

class PublicInfoScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const PublicInfoScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: isDark ? AppColors.surfaceDark : color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, color.withValues(alpha: 0.7)],
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().moveY(begin: 20, end: 0),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : bgColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: color.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.handyman_outlined, // Construction icon
                          size: 64,
                          color: color.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Content Coming Soon',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This section for "$title" is currently being updated with the latest information for the academic (2025) session.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark ? Colors.grey : Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: color,
                            side: BorderSide(color: color),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).scale(),

                  const SizedBox(height: 24),

                  // Mock content to make it look active
                  if (title == "Notices" || title == "Events") ...[
                    _buildMockNoticeItem(
                      context,
                      "Admission 2025 Open",
                      "10 Jan 2025",
                      color,
                    ),
                    _buildMockNoticeItem(
                      context,
                      "School Closed on Monday",
                      "08 Jan 2025",
                      color,
                    ),
                    if (title == "Events")
                      _buildMockNoticeItem(
                        context,
                        "Annual Sports Day",
                        "Next Week",
                        color,
                      ),
                  ],
                  if (title == "Contact") ...[
                    _buildMockContactItem(
                      context,
                      Icons.phone,
                      "+8801712345678",
                      color,
                      onTap: () => launchUrl(Uri.parse("tel:+8801712345678")),
                    ),
                    _buildMockContactItem(
                      context,
                      Icons.email,
                      "info@jacpsc.edu.bd",
                      color,
                      onTap: () =>
                          launchUrl(Uri.parse("mailto:info@jacpsc.edu.bd")),
                    ),
                    _buildMockContactItem(
                      context,
                      Icons.location_on,
                      "Jamuna Cantonment, Tangail",
                      color,
                      onTap: () => launchUrl(
                        Uri.parse(
                          "https://maps.google.com/?q=Jamuna+Cantonment+Public+School",
                        ),
                      ),
                    ),
                  ],
                  if (title == "Admissions") ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.edit_document),
                        label: const Text("Apply Online Now"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Opening Admission Portal..."),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  if (title == "Results") ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.search),
                        label: const Text("Check Results Online"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Navigating to Result Portal..."),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockNoticeItem(
    BuildContext context,
    String title,
    String date,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.article, size: 20, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockContactItem(
    BuildContext context,
    IconData icon,
    String text,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.grey.withValues(alpha: 0.5),
              ),
          ],
        ),
      ),
    );
  }
}
