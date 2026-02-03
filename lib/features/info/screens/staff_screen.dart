import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_inputs.dart';
import '../../../../core/theme/language_provider.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All',
    'Administration',
    'Science',
    'Arts',
    'Support',
  ];

  final List<Map<String, dynamic>> _staffList = [
    {
      'category': 'Administration',
      'name': 'Dr. Md. Rafiqul Islam',
      'role': 'Principal',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAwUxFQxDx7MpvyopUrbON50lgaxGFD1nHWPJkW8m0IUvY0UU4aQcTUyi3HP0n9_SzhGPk02bO7XQT9g3GRohg8nAztYWd8i_dj-v8uwbgxwdWz4OrwDUZnPWS7h4Czgv11waealh3D0R-xXifuif_f1eEpt_zKaosGmMq8BAkHoYknbZ3v7oobZNWTqEaR2mGqs0ymV_w140y3G45_8P45hQ2RR38dYIEDKFjUVTrIhr74R2JKRUooR6F_qPUYjlv5ZrHJpwt1esjn',
      'contactType': 'call',
    },
    {
      'category': 'Administration',
      'name': 'Mrs. Salma Begum',
      'role': 'Vice Principal',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCV8vlPxDGHJGtF7Ty1HKZrA0ETDU-YNJcBu4egT7zvPg44iTJECyLTLWGmfZvI8Fx5vcMgFfyCL404zmilelT6G20XmvwBrKYVFPnD6jHR0tBzkJM00NA3sKLIk8n28ESNl7oKJKNpNfr-DlMstXR4I0mE3Yb2MIkb6UzxbLq0GV_rNg9tNuqhABgidWUcGHKKVg71QJ9KiddWhjb6_5KyJR46JncFmBwON6spEZHDnZWyeZwURYix1BiZrrj9ztI8UKAvk67Dx9zX',
      'contactType': 'email',
    },
    {
      'category': 'Science',
      'name': 'Mr. Ahmed Khan',
      'role': 'Senior Lecturer, Physics',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCgcEeNDB3UU4VgewfvEGjU47_LSEbshb_whcl-XGJT9e4D9B3o5kghlIwIL93P2th3cLdfNJsvGsxCNX-OQ5_d2cEIKJl4PLdtHzlW7uQ4cpFw1D7msU4EmVOGZaa-dgOV_qXC_y1tYyNpOdpO_dW9G0av3ofq0t87PkQX1G2o8uafMqCoSdylkwxY90HpH-0Ek3hqMg4LWtLMeTNQnWCgtzTtKbZqurATdGvT-UAN510NKLY7AshEibnNVuLCbMAiyv83m0FBmTHP',
      'contactType': 'call',
    },
    {
      'category': 'Science',
      'name': 'Ms. Farhana Karim',
      'role': 'Lecturer, Chemistry',
      'imageUrl': '', // No image
      'initials': 'FK',
      'contactType': 'email',
    },
    {
      'category': 'Science',
      'name': 'Dr. Anisur Rahman',
      'role': 'Asst. Professor, Biology',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCB1qOm5td2azmSb3GbJzRlO7pdBGJgTOkTa4Lrv0VPsTWYNb4Hs94gxtRU-HWg0OJLxbudHZZhel_AdAeu7CBBRHVnPcB8DoqMhXpkCX0CSKp67V-kRYAP4WahH1sPuMZo900dXF4m57k6AIpzqf6xGMtoV-zMujUt8ZAEENNOLRULQ0WU-5auhnPqKdTTxZ9jMGZSBN4l3dXmadi11hFrHPzBEtwdGNWXItE-EFV59ssXSLu1NTQsdYDKJ6DoP1g72Piv1ycn7F_Y',
      'contactType': 'call',
    },
    {
      'category': 'Arts',
      'name': 'Mrs. Sarah Jenkins',
      'role': 'Lecturer, English Literature',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkJVRLluBfar6ol9ZK7KC6_r0TfygFEZQRnqsCHtzU07sfbsd5SBJ65-jzVDCPghbWZkYHsRI4hXKITBfPsgowjx6YQVuBS-2ycsQMUhX-tcKFw7yKYANbJUuvgIhKZ9qEY3rR2fLau-4vY0AOu85Kh3cAuDIZVKIlIKf5BkMNjTA7Zdc9z9iPuRzKII5G_VQAIeEFbbiFB-3BOIT1nvDfMDbq-_lV1DkUfe7gdH9QdiUvK0tPsCQLhIBt6cJp-nU2mZmJy0XDkvY-',
      'contactType': 'email',
    },
    {
      'category': 'Arts',
      'name': 'Mr. Hasan Mahmud',
      'role': 'Senior Teacher, History',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBf1NI95ba99hGehw7jsfbV2R_N4g4KoCO3S7Ohf-KCQ6NzMKsnxmajLmOHpocxUhXnms2nmhtiklr09e2JI4bMjYA-IeyFjQKBjjyfQJow1lr4TfCfuYdoXoNcJ3lR7LNqbKojqJN0CAUBdCWNyBHSUhBpo26aTny5T_vXxTHu33Th4Ojpd7Ne3d4i_de822JtroKS03VHVLcyLfPOc9HQx-j0S2RCdnASll99GNAoBDZKKyZbXIKQv6D71xpSDG3tof76wmWOoV_7',
      'contactType': 'call',
    },
    {
      'category': 'Support',
      'name': 'Mr. Mokhlesur Rahman',
      'role': 'Office Superintendent',
      'imageUrl': '',
      'initials': 'MO',
      'contactType': 'call',
    },
  ];

  List<Map<String, dynamic>> get filteredList {
    return _staffList.where((staff) {
      final matchesFilter =
          _selectedFilter == 'All' || staff['category'] == _selectedFilter;
      final matchesSearch =
          staff['name'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          staff['role'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      return matchesFilter && matchesSearch;
    }).toList();
  }

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
              padding: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: isDark ? Colors.white : AppColors.primary,
                          ),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: Text(
                            t(ref, 'staff'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? Colors.white : AppColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // Balance
                      ],
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppSearchField(
                      hint: 'Search by name or department...',
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),

            // Sticky Filter Chips
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: (isDark ? AppColors.surfaceDark : Colors.white)
                    .withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  ),
                ),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return Center(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = filter),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.surfaceDark : Colors.white),
                          borderRadius: BorderRadius.circular(24),
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: isDark
                                      ? Colors.grey.shade700
                                      : Colors.grey.shade300,
                                ),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? Colors.grey.shade200
                                      : AppColors.primary),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Content List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                itemCount: _filters.length - 1, // Exclude 'All'
                itemBuilder: (context, index) {
                  // If filter is selected and it's not All, only show that category
                  // If All is selected, show all categories
                  // Here we iterate categories.
                  final category = _filters[index + 1]; // Skip 'All'

                  if (_selectedFilter != 'All' && _selectedFilter != category) {
                    return const SizedBox.shrink();
                  }

                  final categoryStaff = filteredList
                      .where((s) => s['category'] == category)
                      .toList();
                  if (categoryStaff.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sticky Header Style (Group Header)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 4),
                        child: Text(
                          category == 'Administration'
                              ? 'Administration'
                              : '$category Department',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.blue.shade100
                                : AppColors.primary,
                          ),
                        ),
                      ),
                      ...categoryStaff.map(
                        (staff) => _buildStaffCard(context, staff),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffCard(BuildContext context, Map<String, dynamic> staff) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasImage = (staff['imageUrl'] as String).isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white10
                  : AppColors.primary.withValues(alpha: 0.1),
              image: hasImage
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(staff['imageUrl']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: !hasImage
                ? Text(
                    staff['initials'] ?? '?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  staff['role'],
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Action Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.blue.shade900.withValues(alpha: 0.3)
                  : Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                staff['contactType'] == 'call'
                    ? Icons.call_outlined
                    : Icons.mail_outline,
                size: 20,
                color: isDark ? Colors.blue.shade300 : AppColors.primary,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
