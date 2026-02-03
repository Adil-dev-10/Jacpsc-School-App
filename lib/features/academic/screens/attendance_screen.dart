import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock Data
  final Map<DateTime, String> _attendanceData = {
    DateTime.now().subtract(const Duration(days: 1)): 'present',
    DateTime.now().subtract(const Duration(days: 2)): 'present',
    DateTime.now().subtract(const Duration(days: 3)): 'absent',
    DateTime.now().subtract(const Duration(days: 4)): 'present',
    DateTime.now().subtract(const Duration(days: 5)): 'holiday',
  };

  void _showMonthPicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: const Text('Select Month'),
        content: SizedBox(
          width: 300,
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = index + 1;
              final isSelected = _focusedDay.month == month;
              final monthNames = [
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
              return InkWell(
                onTap: () {
                  setState(() {
                    _focusedDay = DateTime(_focusedDay.year, month, 1);
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : isDark
                        ? Colors.grey[800]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    monthNames[index],
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isDark
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _exportAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting attendance as PDF...')),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
        title: const Text('My Attendance'),
        centerTitle: true,
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: _showMonthPicker,
            tooltip: 'Select Month',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportAttendance,
            tooltip: 'Export PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stats Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  _buildStatCard(
                    context,
                    '92',
                    '%',
                    'Attendance',
                    AppColors.primary,
                    true,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    '22',
                    '',
                    'Working Days',
                    isDark ? Colors.white : Colors.black,
                    false,
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    context,
                    '20',
                    '',
                    'Total Present',
                    AppColors.present,
                    false,
                  ),
                ],
              ),
            ),

            // Calendar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(24),
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
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    final status =
                        _attendanceData[DateTime(
                          date.year,
                          date.month,
                          date.day,
                        )]; // Simplified Key matching
                    // Note: In real app, keys should be normalized day
                    // Just mocking visual markers
                    Color? color;
                    if (status == 'present') color = Colors.green;
                    if (status == 'absent') color = Colors.red;
                    if (status == 'holiday') color = Colors.orange;

                    if (color != null) {
                      return Positioned(
                        bottom: 1,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),

            // Legend
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Present', AppColors.present),
                  const SizedBox(width: 16),
                  _buildLegendItem('Absent', AppColors.absent),
                  const SizedBox(width: 16),
                  _buildLegendItem('Holiday', Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Daily Log Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DAILY LOG',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildLogItem(
                    context,
                    '24',
                    'Oct',
                    'Tuesday',
                    'Present',
                    '08:00 AM - 02:30 PM',
                    AppColors.present,
                    Icons.check_circle,
                  ),
                  _buildLogItem(
                    context,
                    '23',
                    'Oct',
                    'Monday',
                    'Absent',
                    'Sick Leave',
                    AppColors.absent,
                    Icons.cancel,
                  ),
                  _buildLogItem(
                    context,
                    '21',
                    'Oct',
                    'Saturday',
                    'Holiday',
                    'Weekend',
                    Colors.orange,
                    null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String suffix,
    String label,
    Color color,
    bool isPrimary,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                if (suffix.isNotEmpty)
                  Text(
                    suffix,
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(
    BuildContext context,
    String day,
    String month,
    String dayName,
    String status,
    String details,
    Color color,
    IconData? icon,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date Box
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : Colors.blueGrey.shade100,
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
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.blueGrey.shade600,
                  ),
                ),
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blueGrey.shade800,
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
                  dayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  details,
                  style: TextStyle(
                    color: status == 'Absent'
                        ? AppColors.absent
                        : (isDark
                              ? Colors.grey.shade400
                              : Colors.blueGrey.shade500),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Status Pill
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(height: 4),
                Icon(icon, color: color, size: 20),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
