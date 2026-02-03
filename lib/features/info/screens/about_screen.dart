import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'About Us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Principal's Message
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 128,
                                  height: 128,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.grey.shade700
                                          : AppColors.backgroundLight,
                                      width: 4,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDUtmyA_6wX2vKCDQ97JtiO2J7-weAA-78uALo_k9Sl-gWRwNY3GqoBVktoySJQ2QXWytGANf5-b8WS5PkUuge0_pYIj-SdpX1VhGsqGMzLnR29hDcTo_otzgBSY3wnNsCg1Tnln1tLt2R748MWVxNKVhDQuWI8AdfLe5wHewzlAz53iKVbbLqKoOknVcshlsN_EECZs31M3Rm-wOgEYaFvEoHmAb8IO-TyzA3llkHcnt_MbM5pUhNSlRAVG_85txHZBc_gMCsofdjP',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark
                                            ? AppColors.surfaceDark
                                            : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.format_quote_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Brig Gen Md. Example',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.blue.shade200
                                  : AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "PRINCIPAL'S MESSAGE",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '"Welcome to JACPSC. We are committed to fostering academic excellence and moral integrity in every student, preparing them for a bright future."',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward, size: 16),
                            label: const Text('Read full message'),
                            style: TextButton.styleFrom(
                              foregroundColor: isDark
                                  ? Colors.blue.shade200
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // History Section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: 160,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD4aD1N76U0BgbG95STMAyZEb2wf9Wrppu69ZIN_-CEbwZbxPEtAK5vUEj6xR7nL4jNypJ5J81gmPdvzf2Y1k34szmtZPlH_e_-X92Dn9wUNG-DP68S7mi9Ex7JjWm8xJ1kDGPyhuHmLE2ujVpJ4pVO-qb_kfpYKouYF-Op2ZNDID1uC0DEmYklqc3KfAOMfqzy0vzysOwpMh__u_hqcbRXgUod2toa6uiG9mYvTWcXWxkp7WcmCgfkypz9fqOIcvuiuVoxmyFrtR1W',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black87,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.bottomLeft,
                                child: const Text(
                                  'Our History',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Established in 1990, Jamuna Cantonment Public School & College has been a beacon of education, dedicated to nurturing young minds into future leaders.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade800,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.history_edu,
                                        size: 20,
                                        color: isDark
                                            ? Colors.blue.shade200
                                            : AppColors.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Established 1990',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.blue.shade200
                                              : AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Mission & Vision
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            title: 'Our Mission',
                            icon: Icons.flag_rounded,
                            text:
                                'To foster academic excellence and moral integrity.',
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInfoCard(
                            context,
                            title: 'Our Vision',
                            icon: Icons.visibility_rounded,
                            text:
                                'To be the leading educational institution for holistic development.',
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Governing Body
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Governing Body',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: isDark
                                  ? Colors.blue.shade200
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                      children: const [
                        _GoverningBodyMember(
                          name: 'Maj Gen Rahman',
                          role: 'Chairman',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuB2TDEIbxvWfOVIs2oLUXMd4zR_Fym1cWxMPOgdEVU2DsiXG_HqEqVjaPKfQH4ifaRBZqJA4f6PJei1tV8z7dOPN4DlxhI3xuy74SEfBl2PvoN5U_iAJopn4QD4zp8zYTUZiMQGbje1tEnrtISs6SlUYJteAejxB6wWqtuGeyqAyBOfokWmUZFgdSCcx1hPHYHoJv7qeNwymphqXWdfA1tSuRW-IrTSvHHUj-LKazxuDcqZZb89WWfYAvg2wMToNHqtUfY9WyRkyrB6',
                        ),
                        _GoverningBodyMember(
                          name: 'Col. Ahmed Khan',
                          role: 'Member Secretary',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuAzWMH4A_s_fU1FwOyj5mIMT9rRp8ZA3ydxnkzhU2N5rlx9PGuHx8qq188Sd6kpzcSINklDTz7SMzZpWaWpD_ItqhKBW7vKIpk2Ql8PxJ5gItgybjk7PGwrALNN0bdU5bY3m9kM54HA2VU7HJmqzw3ZrCF3YP717FrN9pAIGRl6Bdv7gtbBKVukT0dlPHe2lfOjvUVvnAACf_0-RlyqjGsyosB57IokesRnAOnlEaTugG46IuGtzcSXhGD65ahArZNn36x7aUbQSMFz',
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Footer
                    Center(
                      child: Text(
                        '© 2023 JACPSC. All rights reserved.',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String text,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoverningBodyMember extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const _GoverningBodyMember({
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.blue.shade200 : AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
