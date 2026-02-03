import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';

class AcademicCalendarScreen extends StatefulWidget {
  const AcademicCalendarScreen({super.key});

  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _selectedFilter = 'All'; // Filter state

  // Mock Events Data
  // Keys are normalized dates (UTC midnight)
  final Map<DateTime, List<Map<String, dynamic>>> _events = {
    DateTime.utc(2026, 2, 12): [
      {
        'title': 'Math Olympiad',
        'type': 'Co-curricular',
        'location': 'Main Auditorium',
        'color': Colors.blue,
      },
    ],
    DateTime.utc(2026, 2, 15): [
      {
        'title': 'Term Final Exams Start',
        'type': 'Exam',
        'location': 'All Classes',
        'color': Colors.red,
      },
    ],
    DateTime.utc(2026, 2, 21): [
      {
        'title': 'Durga Puja Holiday',
        'type': 'Holiday',
        'location': 'School Closed',
        'color': Colors.green,
      },
    ],
    DateTime.utc(2026, 3, 26): [
      {
        'title': 'Independence Day',
        'type': 'Holiday',
        'location': 'School Closed',
        'color': Colors.green,
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  List<Map<String, dynamic>> _getFilteredEvents(DateTime day) {
    final events = _getEventsForDay(day);
    if (_selectedFilter == 'All') return events;
    return events.where((e) => e['type'] == _selectedFilter).toList();
  }

  void _showEventDetails(
    BuildContext context,
    Map<String, dynamic> event,
    DateTime date,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = event['color'] as Color;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getEventIcon(event['type']),
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          event['type'],
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildDetailItem(
              Icons.calendar_today,
              'Date',
              '${_getMonthName(date.month)} ${date.day}, ${date.year}',
              isDark,
            ),
            _buildDetailItem(
              Icons.location_on_outlined,
              'Location',
              event['location'],
              isDark,
            ),
            _buildDetailItem(Icons.access_time, 'Time', 'All Day', isDark),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[500] : Colors.grey[500],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'Exam':
        return Icons.edit_note;
      case 'Holiday':
        return Icons.celebration;
      case 'Co-curricular':
        return Icons.emoji_events;
      default:
        return Icons.event;
    }
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
        title: const Text('Academic Calendar'),
        centerTitle: true,
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Calendar Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(24),
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
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2027, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: _getEventsForDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary),
                  ),
                  todayTextStyle: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blueGrey.shade900,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: isDark ? Colors.white : Colors.blueGrey.shade600,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: isDark ? Colors.white : Colors.blueGrey.shade600,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) return null;
                    // Custom markers based on event type color
                    return Positioned(
                      bottom: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: events.map((e) {
                          final event = e as Map<String, dynamic>;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: event['color'] as Color,
                              shape: BoxShape.circle,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Exam', 'Holiday', 'Co-curricular'].map((
                    filter,
                  ) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedFilter = filter);
                        },
                        selectedColor: AppColors.primary.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : isDark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        backgroundColor: isDark
                            ? AppColors.surfaceDark
                            : Colors.grey[100],
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : isDark
                              ? Colors.white10
                              : Colors.grey[300]!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Events List Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.blueGrey.shade900,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_getFilteredEvents(_selectedDay ?? DateTime.now()).length} Events',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Events List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount:
                  _getFilteredEvents(_selectedDay ?? DateTime.now()).isEmpty
                  ? 1
                  : _getFilteredEvents(_selectedDay ?? DateTime.now()).length,
              itemBuilder: (context, index) {
                final events = _getFilteredEvents(
                  _selectedDay ?? DateTime.now(),
                );
                if (events.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'No events for this day.',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  );
                }

                final event = events[index];
                return _buildEventCard(
                  context,
                  event,
                  _selectedDay ?? DateTime.now(),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    Map<String, dynamic> event,
    DateTime date,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = event['color'] as Color;
    final month = _getMonthName(date.month);

    return InkWell(
      onTap: () => _showEventDetails(context, event, date),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.transparent,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            // Date Box
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.blueGrey.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event['type'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.blueGrey.shade500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
