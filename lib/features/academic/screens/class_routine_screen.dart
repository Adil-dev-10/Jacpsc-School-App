import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class ClassRoutineScreen extends StatefulWidget {
  const ClassRoutineScreen({super.key});

  @override
  State<ClassRoutineScreen> createState() => _ClassRoutineScreenState();
}

class _ClassRoutineScreenState extends State<ClassRoutineScreen> {
  String _selectedClass = 'Class 9';
  String _selectedSection = 'Jamuna';
  String _selectedDay = 'Tue';

  final List<String> _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu'];

  // Mock Routine Data
  final Map<String, List<Map<String, dynamic>>> _routineData = {
    'Tue': [
      {
        'subject': 'English 1st Paper',
        'teacher': 'Mrs. Fatema',
        'room': '302',
        'startTime': '08:00',
        'endTime': '08:45',
        'icon': Icons.menu_book,
        'isNow': false,
      },
      {
        'subject': 'General Math',
        'teacher': 'Mr. Rahman',
        'room': '304',
        'startTime': '08:45',
        'endTime': '09:30',
        'icon': Icons.calculate,
        'isNow': true, // Mocking "Now" state
      },
      {
        'subject': 'Physics',
        'teacher': 'Mr. Joy',
        'room': 'Lab 2',
        'startTime': '09:30',
        'endTime': '10:15',
        'icon': Icons.science,
        'isNow': false,
      },
      {'type': 'break', 'duration': '30 min'},
      {
        'subject': 'Biology',
        'teacher': 'Ms. Salma',
        'room': '301',
        'startTime': '10:45',
        'endTime': '11:30',
        'icon': Icons.biotech,
        'isNow': false,
      },
      {
        'subject': 'Bangladesh & Global',
        'teacher': 'Mrs. Rehana',
        'room': '302',
        'startTime': '11:30',
        'endTime': '12:15',
        'icon': Icons.history_edu,
        'isNow': false,
      },
    ],
  };

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
                      'Class Routine',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance for back button
                ],
              ),
            ),

            // Filters
            Container(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Class',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.backgroundDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedClass,
                              isExpanded: true,
                              dropdownColor: isDark
                                  ? AppColors.surfaceDark
                                  : Colors.white,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontSize: 16,
                              ),
                              items: ['Class 9', 'Class 10', 'Class 11']
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null)
                                  setState(() => _selectedClass = val);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.backgroundDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSection,
                              isExpanded: true,
                              dropdownColor: isDark
                                  ? AppColors.surfaceDark
                                  : Colors.white,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontSize: 16,
                              ),
                              items: ['Padma', 'Meghna', 'Jamuna']
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null)
                                  setState(() => _selectedSection = val);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Day Selector
            Container(
              color: isDark
                  ? const Color(0xFF0F2942)
                  : const Color(0xFFE0F2FE), // Sky custom
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _days.map((day) {
                    final isSelected = day == _selectedDay;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedDay = day),
                        child: Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                      ? AppColors.surfaceDark
                                      : Colors.white),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                        ? Colors.blue.shade100
                                        : AppColors.primary),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Routine List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _routineData[_selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = _routineData[_selectedDay]![index];
                  if (item['type'] == 'break') {
                    return _buildBreakDivider(context, item['duration']);
                  }
                  return _buildRoutineCard(context, item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutineCard(BuildContext context, Map<String, dynamic> item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isNow = item['isNow'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: isNow
                  ? Border(left: BorderSide(color: AppColors.primary, width: 4))
                  : Border.all(
                      color: isDark ? Colors.transparent : Colors.transparent,
                    ),
              boxShadow: [
                BoxShadow(
                  color: isNow
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : (isDark ? Colors.black26 : Colors.grey.shade100),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isNow
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : (isDark ? Colors.white10 : const Color(0xFFF0F2F5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'],
                    color: isNow
                        ? AppColors.primary
                        : (isDark ? Colors.blue.shade200 : AppColors.primary),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['subject'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item['teacher']} • ${item['room']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.blueGrey.shade500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item['startTime'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isNow
                            ? AppColors.primary
                            : (isDark
                                  ? Colors.blue.shade200
                                  : AppColors.primary),
                      ),
                    ),
                    Text(
                      item['endTime'],
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.blueGrey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isNow)
            Positioned(
              top: -8,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBreakDivider(BuildContext context, String duration) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              thickness: 1,
              endIndent: 12,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.coffee, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Break ($duration)',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              thickness: 1,
              indent: 12,
            ),
          ),
        ],
      ),
    );
  }
}
