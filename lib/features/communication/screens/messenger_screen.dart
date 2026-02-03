import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class MessengerScreen extends ConsumerWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_comment_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Messages',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'JACPSC Portal',
                        style: TextStyle(
                          color: isDark ? Colors.grey : Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => context.push('/app/new-message'),
                    icon: const Icon(
                      Icons.edit_square,
                      color: AppColors.primary,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search classes or messages...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Main List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  // Pinned Groups Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Text(
                      'PINNED GROUPS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey : Colors.grey.shade500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _buildChatItem(
                    context,
                    chatId: 'physics_10',
                    title: 'Class 10 - Physics',
                    message: 'Sir: Please review Chapter 4 formulas.',
                    time: '2m ago',
                    unread: 3,
                    icon: Icons.science,
                    iconColor: Colors.blue,
                    isPinned: true,
                  ),
                  _buildChatItem(
                    context,
                    chatId: 'science_club',
                    title: 'Science Club',
                    message: "Don't forget the fair registration!",
                    time: '10:45 AM',
                    unread: 1,
                    imageUrl:
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuD3Z6ByJThS6zq6lwZisvDUxUxFX7Q32i4fghWru0Av6WXJptHXTew3wdqI_EbKnKm-3TFeUR1iS_KVyagMKYpP8p3ImR1nHqLlQ4_-Rp5UNDGV-CW7eoqCXAiQq4f04SWnMebqZwRb6cqzxPzPSpaVXgWUaGfX2KW05bG2GmO7vYkNW116H55sbvJf3B6xeP7DUXwEjA1qvCe305EyHE0ahLE-zut3DwVr1L-6AIh6mhd6j6ob-AlEhwj_BtljR06FgPbKo5cur0cY",
                    isPinned: true,
                  ),

                  const SizedBox(height: 16),

                  // All Messages Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Text(
                      'ALL MESSAGES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey : Colors.grey.shade500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _buildChatItem(
                    context,
                    chatId: 'parents_sec_b',
                    title: 'Parents & Teachers (Sec B)',
                    message: 'Meeting scheduled for Friday at 4PM.',
                    time: 'Yesterday',
                    initials: 'PT',
                    iconColor: Colors.grey,
                  ),
                  _buildChatItem(
                    context,
                    chatId: 'biology_9',
                    title: 'Class 9 - Biology',
                    message: 'You: Sir, is the assignment due tomorrow?',
                    time: 'Tue',
                    imageUrl:
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuD6udqjIPfxMy6En0WoA4rvcbMyU-T8nJ4jtstYr5mp3YWJSNwQuLHTvdJozaIIH9eCgWZ27XW5ubLYScAWx0tD_Ux_-mOlaaShsEJTtUA1iCXQzBhQ0KA268sr0slxoSCU_U0AAEkdows7DDxqO6BNCNcyzF-YsgBVcRUslouzKjTdbfdaq_V2GzvBaifBKL6d3ZKYsNLmpNlfxO7Sia8Mc6I7pkDVMpi7MVdThwFUNfh0tRv8srcBUsYNR5TiPukbrT02Lw-ScSmg",
                  ),
                  _buildChatItem(
                    context,
                    chatId: 'sports_team',
                    title: 'JACPSC Sports Team',
                    message: 'Practice cancelled due to rain.',
                    time: 'Mon',
                    icon: Icons.sports_basketball,
                    iconColor: Colors.orange,
                  ),
                  _buildChatItem(
                    context,
                    chatId: 'math_12',
                    title: 'Class 12 - Math',
                    message: 'Calculus test results are out.',
                    time: 'Last week',
                    initials: '12',
                    iconColor: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context, {
    required String chatId,
    required String title,
    required String message,
    required String time,
    int unread = 0,
    String? imageUrl,
    IconData? icon,
    String? initials,
    Color? iconColor,
    bool isPinned = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () =>
          context.push('/app/chat/$chatId?title=${Uri.encodeComponent(title)}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.white10 : Colors.grey.shade100,
            ),
          ),
          color: isPinned
              ? (isDark
                    ? Colors.blue.withValues(alpha: 0.05)
                    : Colors.blue.withValues(alpha: 0.02))
              : null,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: imageUrl == null
                        ? (iconColor?.withValues(alpha: 0.1) ??
                              Colors.grey.shade200)
                        : null,
                    image: imageUrl != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl == null
                      ? Center(child: Icon(icon, color: iconColor, size: 28))
                      : null,
                ),
                if (isPinned)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.backgroundDark
                              : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          color: isDark ? Colors.grey : Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: unread > 0
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: unread > 0
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unread > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unread.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
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
    );
  }
}
