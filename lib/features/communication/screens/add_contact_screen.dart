import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _addedContacts = {};

  // Mock suggested contacts
  final List<Map<String, dynamic>> _suggestedContacts = [
    {
      'id': 'arifur_rahman',
      'name': 'Md. Arifur Rahman',
      'role': 'Physics - Faculty',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsgQQ7-IyYLOXoQm-b7jyMvYtXtuyBnBCnjRSSkhxGuPGAvicZfNQq8f89sLFQzb3UUV5TDzgRKtNXuyfrvtavSnNzzJaStVIYT3ejrPtmHzUK9loqiV1RQ5KewTLl09eyEoC-S6jof9Gn9mveUEcuslVAo9NYsh1BJhOHHmRZqawknNur4TkO66ZnlksWuLfYWsfODc4XaScPNgGoUgJ2PRZyWUgfo9rBelyWEAd1qW5Q9srWvKgNb_muH1OOG35hfe3xRpr_TZSd',
    },
    {
      'id': 'sultana_naznin',
      'name': 'Sultana Naznin',
      'role': 'Biology - Faculty',
      'initials': 'SN',
    },
    {
      'id': 'tahmina_akter',
      'name': 'Tahmina Akter',
      'role': 'Class 10 - Student',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD_HpXIpG4h3nDcbwXXMan-W0ndAjQvBk1iE8eNJHRZr3QlNFbrkzFOmxTFAXMXo43uIo9u9uPu2G1n6X5P_a43W94MrSEl9j7RJpIOxw04QDOA4mZsVIPKAzqS0vJcE1x16gd-3H32VWNRWiJrsqlqGJ-CjzkxcUbyln7Tys26xhFAoqRTkX36JDXLqad23ZK16dY6PwrHtyYJaWzvLd4z_wNzX8436tYFxWj8reuMTOq4KBJUDVghsS1BXP8k6vDVd1NglZ4EXkw1',
    },
    {
      'id': 'kamrul_hasan',
      'name': 'Kamrul Hasan',
      'role': 'ICT Dept - Faculty',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDhC7NoRxpkrFkeG_olfxqqpCQARfMcoPc7e1C71lmzzCyARuOAtyOoSwzsd3cBORWtcNJreRMtoGQ0JGnhsUi1djO6gzeX2d7M-w_YCZPtlnjIJor4Hsm4vsDJiOI8fGOds1vosTNraSiuR1hEdH-I0P5v7uZDolaZ1Pv42MzSRM08mFIZn3gj1ugR_w00ZKlVi9X-WmeX1JXBcQqBYp5RZTL1LsTW6kJcRluayByseSqHnDf_ZQCPpRn6WayoujOoRUM-T4ImMikp',
    },
    {
      'id': 'rashed_ahmed',
      'name': 'Rashed Ahmed',
      'role': 'Mathematics - Student',
      'initials': 'RA',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addContact(String contactId) {
    setState(() {
      _addedContacts.add(contactId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contact added successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
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
          'Add Contact',
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
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Find by Name or Student/Teacher ID',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  filled: true,
                  fillColor: isDark
                      ? AppColors.surfaceDark
                      : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // QR Code Scanner Option
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('QR Scanner coming soon...')),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scan QR Code',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              'Add quickly via profile scan',
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
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade400,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Suggested Contacts Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'SUGGESTED CONTACTS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.primary : AppColors.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // Contact List
            ..._suggestedContacts.map(
              (contact) => _buildContactItem(contact, isDark),
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

  Widget _buildContactItem(Map<String, dynamic> contact, bool isDark) {
    final hasImage = contact['imageUrl'] != null;
    final isAdded = _addedContacts.contains(contact['id']);

    return Container(
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
          // Avatar
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
                      image: CachedNetworkImageProvider(contact['imageUrl']),
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
          const SizedBox(width: 12),
          // Contact info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contact['role'],
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Add Button
          if (!isAdded)
            ElevatedButton(
              onPressed: () => _addContact(contact['id']),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, color: Colors.green, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Added',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
