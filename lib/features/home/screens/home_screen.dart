import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/theme/language_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = ref.watch(authProvider).user;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Space for bottom nav
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white24,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundImage: CachedNetworkImageProvider(
                                user?.profileImage ??
                                    "https://i.pravatar.cc/300",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getGreeting(ref),
                            style: TextStyle(
                              color: Colors.blue.shade100,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            user?.name ?? 'Student Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => context.push('/app/notices'),
                        ),
                        const Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Event Carousel
            SizedBox(
              height: 180,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                padEnds: false,
                children: [
                  _buildEventCard(
                    "Annual Science Fair 2023",
                    "Highlights from yesterday's amazing projects.",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuC01RJJlOjCEYGDV21EXAe79m52Em208wTHpR4LMU8S6UgNDiYOj8av2a5vTGYf3scmaRbwW3a3qV065hsz9Ox8tlHxRdfCJzeKXy1AntcML1_e48AX2wZH2we4ZXdvkxgwpG5_5VI3kZMuATa5O_ZPQxbK3wUjVlioIUgmX1to8z8qHvQZt6L2sN82PxxClPcDBVjpjQdnZqO-y_jm4RBTYtDxo48hvECK7zZpZDlW8xfAzYw-BFB7bWnSCV83QhdqGBhWKdVIeVZH",
                    "EVENT",
                    Colors.blue,
                  ),
                  _buildEventCard(
                    "Inter-House Debate Finals",
                    "Watch the replay of the intense final round.",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuDE8NOHnofoNj2BPJAGg5LQZMO5Cj1XEzn2bhM4OjJwvLpLAqkXCHYeC0lcH-ClHCIh8FAYgHbuvQNvgV4onaooT9UNYIy6DUJAQF7XXTBIt2_o-p0YfU_fwwjpBfWPlKJGqbVw4lsr_Ly6ZNR8OC0aqQEvUotuACkWHftRMJJOKtN533CT3SXmlVJlzXgMMEzWs8EoClFYiId1UlmVhaHfSAtjXYT7YmFhOuFDWl0TynNHYIG2Zt85PGOrYRGTUNX0nQoEeTUdmWnS",
                    "COMPETITION",
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Access
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t(ref, 'quickAccess'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white70 : Colors.grey.shade600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      _buildQuickAccessTile(
                        context,
                        t(ref, 'academic'),
                        Icons.menu_book,
                        Colors.blue,
                        '/app/syllabus',
                      ),
                      _buildQuickAccessTile(
                        context,
                        t(ref, 'attendance'),
                        Icons.calendar_month,
                        Colors.green,
                        '/app/attendance',
                      ),
                      _buildQuickAccessTile(
                        context,
                        t(ref, 'results'),
                        Icons.analytics,
                        Colors.purple,
                        '/app/results',
                      ),
                      _buildQuickAccessTile(
                        context,
                        t(ref, 'fees'),
                        Icons.payments,
                        Colors.orange,
                        '/app/fees',
                      ),
                      _buildQuickAccessTile(
                        context,
                        t(ref, 'routine'),
                        Icons.schedule,
                        Colors.cyan,
                        '/app/routine',
                      ),
                      _buildQuickAccessTile(
                        context,
                        t(ref, 'more'),
                        Icons.grid_view,
                        Colors.grey,
                        '/app/menu',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Upcoming Classes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t(ref, 'upcomingClasses'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text(t(ref, 'seeAll'))),
                ],
              ),
            ),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildClassCard(
                    context,
                    "Mathematics",
                    "Mr. Rahman",
                    "Room 302",
                    "09:00 AM",
                    Colors.blue,
                  ),
                  _buildClassCard(
                    context,
                    "Physics",
                    "Ms. Nasreen",
                    "Lab 2",
                    "10:00 AM",
                    Colors.purple,
                  ),
                  _buildClassCard(
                    context,
                    "Chemistry",
                    "Mr. Ahmed",
                    "Lab 4",
                    "11:30 AM",
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Notices
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t(ref, 'recentNotices'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text(t(ref, 'viewAll'))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildNoticeDisplay(
                    context,
                    "Eid-ul-Fitr Holiday",
                    "School will remain closed from 12th April.",
                    "10 Apr",
                    true,
                  ),
                  _buildNoticeDisplay(
                    context,
                    "Half-Yearly Exam Schedule",
                    "The schedule for classes VI-X has been published.",
                    "08 Apr",
                    false,
                  ),
                  _buildNoticeDisplay(
                    context,
                    "Science Fair Registration",
                    "Last date for project submission is near.",
                    "05 Apr",
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting(WidgetRef ref) {
    final hour = DateTime.now().hour;
    if (hour < 12) return t(ref, 'goodMorning');
    if (hour < 17) return t(ref, 'goodAfternoon');
    return t(ref, 'goodEvening');
  }

  Widget _buildEventCard(
    String title,
    String subtitle,
    String imageUrl,
    String tag,
    Color tagColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        right: 16,
        left: 20,
      ), // Left margin only for first item usually, but PageView handles logic differently. Simplified here.
      // Correction: PageView children fill viewport fraction. Margin should be symmetric if focused or just right padding.
      // Let's use Margin right only and handle first item padding via ListView if it was list. For PageView, centering is default.
      // Actually standard PageView logic:
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Colors.black87, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessTile(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String route,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => context.push(route),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? color.withValues(alpha: 0.2)
                    : color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDark ? color.withValues(alpha: 0.8) : color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(
    BuildContext context,
    String subject,
    String teacher,
    String room,
    String time,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? color.withValues(alpha: 0.2)
                      : color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.more_vert, size: 18, color: Colors.grey.shade400),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            subject,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(
                teacher,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.meeting_room, size: 16, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(
                room,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeDisplay(
    BuildContext context,
    String title,
    String subtitle,
    String date,
    bool isNew,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  date.split(' ')[1],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey : Colors.blue.shade800,
                  ),
                ), // Month
                Text(
                  date.split(' ')[0],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.primary,
                  ),
                ), // Day
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    if (isNew)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
