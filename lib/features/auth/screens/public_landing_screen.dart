import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class PublicLandingScreen extends StatelessWidget {
  const PublicLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.publicBackgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.publicPrimary,
                        AppColors.publicSecondary,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'JACPSC',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white, // Required for ShaderMask
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/login'),
                    style:
                        ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 0,
                          ), // Adjust height via visual density or fixed size if needed
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ).copyWith(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                    // Workaround for Gradient Button: Use Container content or decor
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.publicPrimary,
                            AppColors.publicSecondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(99),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.publicPrimary.withValues(
                              alpha: 0.2,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  // Note: The previous button implementations was messy. Let's fix it.
                  // A simpler Gradient Button:
                ],
              ),
            ),

            // Re-doing the Header Button properly
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 8),

                  // header fix (putting the button properly outside list view above was okay, but let's refine the button code separately).
                  // I'll stick to standard button for now to be safe or use a custom widget later.
                  // The previous code had nested button which is bad. Let's assume standard button for MVP.

                  // Hero Image (Annual Sports Day)
                  InkWell(
                    onTap: () => context.push('/public/events'),
                    borderRadius: BorderRadius.circular(24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDly4UtlgbVuxCxqrt0AC1S_menYBFmVmdrLKrzWC6-9yel8jWrEjXTPquyIE5oiHE0uVTpo-JUlWsS27xb3xykOu2hZ55v_pftpbq9zqhz-QZcbeGdjmC86lt1grbTiSujnzkZrU8od_MareRCgM9vw2ixo8PrLvOgWoO47CCOkeJPHl_RJjitnIXywvNwnUydRxek7FUdDxC0wY_Nxf6XTv21V7Gj7T-VbFbQ4T0_D0vVc90D2OR5Dmo4UlCMoUl-zKlAtMZ3AHZZ",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container(color: Colors.grey.shade200),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black12,
                                    Colors.black54,
                                    Colors.black87,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.publicAccent,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: const Text(
                                    'UPCOMING EVENT',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Annual Sports Day',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Join us for a day of athletic achievements and school spirit.',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn().scale(duration: 600.ms, curve: Curves.easeOut),
                  ),

                  const SizedBox(height: 32),

                  // Principal's Voice
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Principal\'s Voice',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'INSPIRATION',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.publicPrimary,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.publicGradient,
                              ),
                              child: const CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDcgh40YSovO0mSRBLoQFbC3D2dVlrpY2gKeJVM2Wm6o0uJIIGrcxQk71971pLaLtSsUNWxmZxrg3Mojj8dkcB3vxwetjbOAnDpKrBzfmBBry1sHelVdiv7BMVZ_6yF9XalKhui3xs_cO8q1XFqOGhaEqHdQRrJsaBV5iOpddU6HWsoq7n2EoJV9KKkF-H4dJgh4pBEAuGo93azjWlvi0U0lIUgQNfIefKqnlk6TldB3kKsV4Sd2QXqbMdt0KkKGWNQbZmEm07gNuOZ",
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Anya Sharma',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'VISIONARY LEADER',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: AppColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '"Welcome to JACPSC, where every student\'s unique potential is nurtured with care and celebrated with joy. We don\'t just teach; we inspire excellence."',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => context.push('/public/about'),
                          child: Row(
                            children: [
                              Text(
                                'Discover our Philosophy',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.blue.shade300
                                      : AppColors.publicPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: isDark
                                    ? Colors.blue.shade300
                                    : AppColors.publicPrimary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).moveY(begin: 30, end: 0),

                  const SizedBox(height: 32),

                  // Campus Hub Grid
                  Text(
                    'Campus Hub',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      _buildHubCard(
                        context,
                        'Admissions',
                        'Join Our Family',
                        Icons.menu_book,
                        Colors.blue,
                        Colors.blue.shade50,
                        '/public/admissions',
                      ),
                      _buildHubCard(
                        context,
                        'Results',
                        'Track Success',
                        Icons.stars,
                        AppColors.publicBrandGreen,
                        const Color(0xFFF0FDF4),
                        '/public/results',
                      ),
                      _buildHubCard(
                        context,
                        'Gallery',
                        'Life at JACPSC',
                        Icons.photo_library,
                        AppColors.publicBrandPink,
                        const Color(0xFFFDF2F8),
                        '/public/gallery',
                      ),
                      _buildHubCard(
                        context,
                        'Notices',
                        'Latest Updates',
                        Icons.campaign,
                        AppColors.publicAccent,
                        const Color(0xFFFFF7ED),
                        '/public/notices',
                      ),
                      _buildHubCard(
                        context,
                        'Contact',
                        'Get in Touch',
                        Icons.alternate_email,
                        AppColors.publicPrimary,
                        const Color(0xFFF8FAFC),
                        '/public/contact',
                      ),
                      _buildHubCard(
                        context,
                        'Faculty',
                        'Meet Mentors',
                        Icons.groups_3,
                        AppColors.publicPrimary,
                        const Color(0xFFF8FAFC),
                        '/public/faculty',
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms).moveY(begin: 50, end: 0),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHubCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Color bg,
    String route,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : bg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? Colors.white10 : color.withValues(alpha: 0.1),
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: color.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: color.withValues(alpha: 0.8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
