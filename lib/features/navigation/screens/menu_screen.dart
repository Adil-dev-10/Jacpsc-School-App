import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/theme/language_provider.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = ref.watch(authProvider).user;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(t(ref, 'menu')),
        centerTitle: true,
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/app/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF1E40AF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundImage: CachedNetworkImageProvider(
                        user?.profileImage ?? "https://i.pravatar.cc/300",
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Student Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Class 10 - Science B (Roll 12)',
                          style: TextStyle(
                            color: Colors.blue.shade100,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () => context.push('/app/profile'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              t(ref, 'viewProfile'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _buildSection(context, t(ref, 'general'), [
              _MenuOption(
                t(ref, 'schoolInfo'),
                Icons.info_outline,
                Colors.blue,
                '/app/about',
              ),
              _MenuOption(
                t(ref, 'gallery'),
                Icons.photo_library_outlined,
                Colors.purple,
                '/app/gallery',
              ),
              _MenuOption(
                t(ref, 'events'),
                Icons.event_available,
                Colors.orange,
                '/app/events',
              ),
              _MenuOption(
                t(ref, 'staff'),
                Icons.people_outline,
                Colors.teal,
                '/app/staff',
              ),
            ]),

            _buildSection(context, t(ref, 'academic'), [
              _MenuOption(
                t(ref, 'routine'),
                Icons.schedule,
                Colors.cyan,
                '/app/routine',
              ),
              _MenuOption(
                t(ref, 'syllabus'),
                Icons.menu_book,
                Colors.indigo,
                '/app/syllabus',
              ),
              _MenuOption(
                t(ref, 'calendar'),
                Icons.calendar_month,
                Colors.red,
                '/app/calendar',
              ),
              _MenuOption(
                t(ref, 'books'),
                Icons.library_books,
                Colors.brown,
                '/app/books',
              ),
              _MenuOption(
                t(ref, 'attendance'),
                Icons.fact_check_outlined,
                Colors.green,
                '/app/attendance',
              ),
              _MenuOption(
                t(ref, 'results'),
                Icons.analytics_outlined,
                Colors.deepPurple,
                '/app/results',
              ),
            ]),

            _buildSection(context, t(ref, 'communication'), [
              _MenuOption(
                t(ref, 'notices'),
                Icons.campaign_outlined,
                Colors.amber,
                '/app/notices',
              ),
              _MenuOption(
                t(ref, 'messages'),
                Icons.chat_bubble_outline,
                Colors.pink,
                '/app/messages',
              ),
              _MenuOption(
                t(ref, 'feedback'),
                Icons.rate_review_outlined,
                Colors.lightGreen,
                '/app/feedback',
              ),
            ]),

            _buildSection(context, t(ref, 'admissionFees'), [
              _MenuOption(
                t(ref, 'fees'),
                Icons.payments_outlined,
                Colors.green,
                '/app/fees',
              ),
              _MenuOption(
                t(ref, 'admission'),
                Icons.app_registration,
                Colors.blueGrey,
                '/app/admission',
              ),
            ]),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                  context.go('/landing');
                },
                icon: const Icon(Icons.logout),
                label: Text(t(ref, 'logOut')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),

            const SizedBox(height: 120), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<_MenuOption> options,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.brightness == Brightness.dark
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
                letterSpacing: 1.1,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Changed to 3 for better fit on mobile
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              final isDark = theme.brightness == Brightness.dark;
              return InkWell(
                onTap: () => context.push(
                  option.route,
                ), // Will show page not found for now unless implemented
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.grey.shade100,
                    ),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark
                              ? option.color.withValues(alpha: 0.2)
                              : option.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(option.icon, color: option.color, size: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        option.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuOption {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  _MenuOption(this.title, this.icon, this.color, this.route);
}
