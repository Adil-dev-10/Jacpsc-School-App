import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_inputs.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Secondary',
    'Higher Secondary',
    'Primary',
  ];

  final List<Map<String, dynamic>> _syllabusList = [
    {
      'title': 'Class 9 (Science Group)',
      'subtitle': 'Session 2023-2024 • 2.4 MB',
      'category': 'Secondary',
      'isDownloadable': true,
    },
    {
      'title': 'Class 9 (Arts Group)',
      'subtitle': 'Session 2023-2024 • 2.1 MB',
      'category': 'Secondary',
      'isDownloadable': true,
    },
    {
      'title': 'Class 10 (Commerce)',
      'subtitle': 'Exam Routine & Syllabus • 1.8 MB',
      'category': 'Secondary',
      'isDownloadable': true,
    },
    {
      'title': 'HSC 1st Year (Science)',
      'subtitle': 'Physics, Chemistry, Math • 5.2 MB',
      'category': 'Higher Secondary',
      'isDownloadable': false, // View only
    },
    {
      'title': 'HSC 2nd Year (English)',
      'subtitle': 'Full Syllabus 2024 • 3.5 MB',
      'category': 'Higher Secondary',
      'isDownloadable': true,
    },
  ];

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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              color: AppColors.primary,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Syllabus',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Search Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: isDark
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              child: const AppSearchField(hint: 'Search class or subject...'),
            ),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
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
                          boxShadow: isSelected
                              ? null
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? Colors.grey.shade200
                                      : Colors.black87),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Grouped Content List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: _buildGroupedList(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGroupedList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    List<Widget> children = [];

    // Categories to show
    List<String> categoriesToShow = _selectedFilter == 'All'
        ? ['Secondary', 'Higher Secondary', 'Primary']
        : [_selectedFilter];

    bool hasItems = false;

    for (var category in categoriesToShow) {
      final items = _syllabusList
          .where((item) => item['category'] == category)
          .toList();

      if (items.isEmpty) continue;
      hasItems = true;

      // Section Header
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 8, left: 4),
          child: Text(
            '$category Section',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.blue.shade200 : AppColors.primary,
            ),
          ),
        ),
      );

      // Items
      for (var item in items) {
        children.add(_buildSyllabusCard(context, item));
      }

      children.add(const SizedBox(height: 12));
    }

    if (!hasItems) {
      children.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_open_rounded,
                  size: 64,
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'No syllabus found',
                  style: TextStyle(
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // End of list indicator
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.folder_open,
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'End of list',
                  style: TextStyle(
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return children;
  }

  Widget _buildSyllabusCard(BuildContext context, Map<String, dynamic> item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDownloadable = item['isDownloadable'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade100,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.red.withValues(alpha: 0.2)
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.picture_as_pdf,
              color: isDark ? Colors.red.shade300 : const Color(0xFFE11D48),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item['subtitle'],
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Action Button
          if (isDownloadable)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade700
                    : AppColors.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.download,
                  size: 20,
                  color: isDark ? Colors.blue.shade300 : AppColors.primary,
                ),
                onPressed: () {},
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.blue.shade900.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'View',
                style: TextStyle(
                  color: isDark ? Colors.blue.shade200 : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
