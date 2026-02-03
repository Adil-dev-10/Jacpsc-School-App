import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Mock data
  final List<Map<String, dynamic>> _recentContacts = [
    {
      'name': 'Md. Arifur Rahman',
      'role': 'Physics - Class 10',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsgQQ7-IyYLOXoQm-b7jyMvYtXtuyBnBCnjRSSkhxGuPGAvicZfNQq8f89sLFQzb3UUV5TDzgRKtNXuyfrvtavSnNzzJaStVIYT3ejrPtmHzUK9loqiV1RQ5KewTLl09eyEoC-S6jof9Gn9mveUEcuslVAo9NYsh1BJhOHHmRZqawknNur4TkO66ZnlksWuLfYWsfODc4XaScPNgGoUgJ2PRZyWUgfo9rBelyWEAd1qW5Q9srWvKgNb_muH1OOG35hfe3xRpr_TZSd',
      'isOnline': true,
      'chatId': 'arifur_rahman',
    },
    {
      'name': 'Sultana Naznin',
      'role': 'Biology - Class 9',
      'initials': 'SN',
      'isOnline': false,
      'chatId': 'sultana_naznin',
    },
  ];

  final List<Map<String, dynamic>> _allTeachers = [
    {
      'name': 'Dr. Tahmina Akter',
      'role': 'Senior Lecturer, Chemistry',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD_HpXIpG4h3nDcbwXXMan-W0ndAjQvBk1iE8eNJHRZr3QlNFbrkzFOmxTFAXMXo43uIo9u9uPu2G1n6X5P_a43W94MrSEl9j7RJpIOxw04QDOA4mZsVIPKAzqS0vJcE1x16gd-3H32VWNRWiJrsqlqGJ-CjzkxcUbyln7Tys26xhFAoqRTkX36JDXLqad23ZK16dY6PwrHtyYJaWzvLd4z_wNzX8436tYFxWj8reuMTOq4KBJUDVghsS1BXP8k6vDVd1NglZ4EXkw1',
      'chatId': 'tahmina_akter',
    },
    {
      'name': 'Kamrul Hasan',
      'role': 'Assistant Teacher, ICT',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDhC7NoRxpkrFkeG_olfxqqpCQARfMcoPc7e1C71lmzzCyARuOAtyOoSwzsd3cBORWtcNJreRMtoGQ0JGnhsUi1djO6gzeX2d7M-w_YCZPtlnjIJor4Hsm4vsDJiOI8fGOds1vosTNraSiuR1hEdH-I0P5v7uZDolaZ1Pv42MzSRM08mFIZn3gj1ugR_w00ZKlVi9X-WmeX1JXBcQqBYp5RZTL1LsTW6kJcRluayByseSqHnDf_ZQCPpRn6WayoujOoRUM-T4ImMikp',
      'chatId': 'kamrul_hasan',
    },
    {
      'name': 'Rashed Ahmed',
      'role': 'Mathematics Dept.',
      'initials': 'RA',
      'chatId': 'rashed_ahmed',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'New Message',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search teachers or students...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: Icons.group_add_outlined,
                      label: 'New Group',
                      isDark: isDark,
                      onTap: () => context.push('/app/new-group'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: Icons.person_add_outlined,
                      label: 'New Contact',
                      isDark: isDark,
                      onTap: () => context.push('/app/add-contact'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Contacts Section
            _buildSectionHeader('RECENT CONTACTS', isDark),
            ..._recentContacts.map(
              (contact) => _buildContactItem(
                context,
                contact: contact,
                isDark: isDark,
                showOnlineIndicator: true,
              ),
            ),

            const SizedBox(height: 16),

            // All Teachers Section
            _buildSectionHeader('ALL TEACHERS', isDark),
            ..._allTeachers.map(
              (contact) => _buildContactItem(
                context,
                contact: contact,
                isDark: isDark,
                showOnlineIndicator: false,
              ),
            ),

            const SizedBox(height: 32),

            // Footer
            Center(
              child: Text(
                'MADE WITH ADIL-DEV',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required Map<String, dynamic> contact,
    required bool isDark,
    required bool showOnlineIndicator,
  }) {
    final hasImage = contact['imageUrl'] != null;
    final isOnline = contact['isOnline'] ?? false;

    return InkWell(
      onTap: () {
        final chatId = contact['chatId'] ?? 'unknown';
        final title = contact['name'] ?? 'Chat';
        context.push('/app/chat/$chatId?title=${Uri.encodeComponent(title)}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.white10 : Colors.grey.shade100,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hasImage
                        ? null
                        : (isDark
                              ? Colors.grey.shade700
                              : AppColors.primary.withValues(alpha: 0.1)),
                    image: hasImage
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              contact['imageUrl'],
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !hasImage
                      ? Center(
                          child: Text(
                            contact['initials'] ?? '?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : AppColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                if (showOnlineIndicator && isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.backgroundDark
                              : AppColors.backgroundLight,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Contact info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact['role'],
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
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
