import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/theme/language_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // Header with Cover & Avatar
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Cover Image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuDT2D-Y282q1Jt9P1r87bL-t5c5qJ6g9M2W7Vj9yX3P4bK0O8n1R5e7sL9z2vH4wQ6m3kU0xC8a1B5yD9o3E4fG5h7i2j8k4l6mQ9n3p0r1s2t5u8v7w9x0y1z2A3B4C5D6E7F8G9H0I1J2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8",
                      ), // School building or abstract
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Back Button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                // Settings Button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => context.push('/app/settings'),
                    ),
                  ),
                ),
                // Edit Button

                // Profile Avatar overlapping
                Positioned(
                  bottom: -60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.backgroundDark : Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(
                        user?.profileImage ?? "https://i.pravatar.cc/300",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70), // Spacing for avatar
            // Name & ID
            Text(
              user?.name ?? 'Student Name',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ID: ${user?.id ?? "123456"}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      context,
                      t(ref, 'digitalId'),
                      Icons.badge,
                      AppColors.primary,
                      () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickActionButton(
                      context,
                      t(ref, 'editProfile'),
                      Icons.edit_square,
                      Colors.orange,
                      () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Academic Info
            _buildSectionHeader(context, t(ref, 'academicInfo')),
            _buildInfoCard(context, [
              _InfoRow(Icons.school, t(ref, 'class'), 'Class 10'),
              _InfoRow(Icons.class_, t(ref, 'section'), 'Science B'),
              _InfoRow(Icons.confirmation_number, t(ref, 'rollNumber'), '12'),
              _InfoRow(Icons.calendar_today, t(ref, 'session'), '2023-2024'),
            ]),

            const SizedBox(height: 24),

            // Personal Information
            _buildSectionHeader(context, t(ref, 'personalDetails')),
            _buildInfoCard(context, [
              _InfoRow(Icons.male, t(ref, 'gender'), 'Male'), // Dynamic later
              _InfoRow(Icons.bloodtype, t(ref, 'bloodGroup'), 'B+'),
              _InfoRow(Icons.cake, t(ref, 'dob'), '15 Aug 2008'),
              _InfoRow(Icons.people, t(ref, 'fatherName'), 'Md. Abdul Rahman'),
              _InfoRow(
                Icons.people_outline,
                t(ref, 'motherName'),
                'Mrs. Fatema Begum',
              ),
            ]),

            const SizedBox(height: 24),

            // Contact Information
            _buildSectionHeader(context, t(ref, 'contactInfo')),
            _buildInfoCard(context, [
              _InfoRow(Icons.phone, t(ref, 'phone'), '+880 1712 345678'),
              _InfoRow(Icons.email, t(ref, 'email'), 'student@jacpsc.edu.bd'),
              _InfoRow(
                Icons.location_on,
                t(ref, 'address'),
                'House 12, Road 5, Cantonment Area, Dhaka',
              ),
            ]),

            const SizedBox(height: 16),

            // Map Placeholder
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://maps.googleapis.com/maps/api/staticmap?center=23.8103,90.4125&zoom=15&size=600x300&key=YOUR_API_KEY_HERE_PLACEHOLDER",
                  ), // Use a generic map image or leave placeholder color
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(Icons.map, size: 40, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.shade200,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey.shade800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<_InfoRow> rows) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
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
        children: rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(row.icon, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row.label,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            row.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (index != rows.length - 1)
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.grey.shade100,
                  indent: 60,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoRow {
  final IconData icon;
  final String label;
  final String value;
  _InfoRow(this.icon, this.label, this.value);
}
