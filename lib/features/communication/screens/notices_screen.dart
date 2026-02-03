import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_inputs.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filters = [
    'All',
    'Important',
    'Academic',
    'Sports',
    'Events',
    'Holidays',
  ];

  final Map<String, dynamic> _heroNotice = {
    'title': 'Revised Examination Schedule for Class X & XII',
    'date': 'Today',
    'tag': 'Important',
    'description':
        'Please refer to the attached document regarding the changes in the upcoming board examination dates due to unforeseen circumstances.',
  };

  final List<Map<String, dynamic>> _notices = [
    {
      'day': '24',
      'month': 'OCT',
      'title': 'Annual Sports Day Registration',
      'description':
          'Registration for the annual sports meet is now open. Students interested in participating in track and field events.',
      'time': '10:30 AM',
      'type': 'Sports',
    },
    {
      'day': '22',
      'month': 'OCT',
      'title': 'Winter Uniform Guidelines',
      'description':
          'All students are expected to switch to the winter uniform starting from November 1st. Details attached.',
      'time': '09:15 AM',
      'type': 'General',
    },
    {
      'day': '18',
      'month': 'OCT',
      'title': 'Parent-Teacher Meeting (PTM)',
      'description':
          'The PTM for Term 1 results will be held on Saturday. Slots have been emailed to parents.',
      'time': '2:00 PM',
      'type': 'Events',
    },
    {
      'day': '10',
      'month': 'OCT',
      'title': 'Eid-ul-Fitr Holiday',
      'description': 'School will remain closed from 12th April to 18th April.',
      'time': '08:00 AM',
      'type': 'Holidays',
    },
  ];

  List<Map<String, dynamic>> get _filteredNotices {
    return _notices.where((notice) {
      final matchesFilter =
          _selectedFilter == 'All' ||
          notice['type'] == _selectedFilter ||
          (_selectedFilter == 'Important' &&
              notice['type'] == 'General'); // Mapping logic simplification
      // Note: In a real app, 'Important' would be a flag, not just a type map.
      // For demo, we are showing list.

      final matchesSearch =
          notice['title'].toString().toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          notice['description'].toString().toLowerCase().contains(
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
            // Sticky Header Section
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceDark
                    : Colors.white.withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Title Bar
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 8,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Notice Board',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: AppSearchField(
                      hint: 'Search notices...',
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      top: 8,
                    ),
                    child: Row(
                      children: _filters.map((filter) {
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedFilter = filter),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark
                                          ? Colors.grey.shade800
                                          : Colors.white),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDark
                                            ? Colors.grey.shade700
                                            : Colors.grey.shade200),
                                ),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                            ? Colors.grey.shade300
                                            : Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Content List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Hero Notice (Only show if 'All' or 'Important' is selected)
                  if (_selectedFilter == 'All' ||
                      _selectedFilter == 'Important')
                    _buildHeroNotice(context),

                  if (_selectedFilter == 'All' ||
                      _selectedFilter == 'Important')
                    const SizedBox(height: 24),

                  // Latest Updates Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Updates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        'October 2024',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // List API
                  ..._filteredNotices.map(
                    (notice) => _buildNoticeCard(context, notice),
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "You're all caught up",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade400,
                          letterSpacing: 0.5,
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
    );
  }

  Widget _buildHeroNotice(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.push_pin, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      _heroNotice['tag'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _heroNotice['date'],
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _heroNotice['title'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _heroNotice['description'],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Read full notice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeCard(BuildContext context, Map<String, dynamic> notice) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color badgeColor;
    Color badgeBg;

    switch (notice['type']) {
      case 'Sports':
        badgeColor = AppColors.primary;
        badgeBg = Colors.blue.shade50;
        break;
      case 'Events':
        badgeColor = Colors.purple;
        badgeBg = Colors.purple.shade50;
        break;
      case 'Holidays':
        badgeColor = Colors.orange;
        badgeBg = Colors.orange.shade50;
        break;
      default:
        badgeColor = Colors.grey.shade600;
        badgeBg = Colors.grey.shade100;
    }

    if (isDark) {
      badgeBg = badgeColor.withValues(alpha: 0.1);
      badgeColor = badgeColor.withValues(alpha: 0.8);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Box
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.blue.shade100,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notice['month'],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey.shade400 : AppColors.primary,
                  ),
                ),
                Text(
                  notice['day'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notice['title'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isDark) // Dot for decoration
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notice['description'],
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notice['time'],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        notice['type'].toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: badgeColor,
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
    );
  }
}
