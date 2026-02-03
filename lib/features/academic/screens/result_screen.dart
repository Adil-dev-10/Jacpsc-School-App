import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_inputs.dart';
import '../../../../shared/widgets/app_buttons.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? _selectedClass;
  String? _selectedYear;
  final TextEditingController _rollController = TextEditingController();
  bool _showResult = false;
  bool _isLoading = false;

  final List<String> _classes = [
    'Class IX',
    'Class X',
    'Class XI',
    'Class XII',
  ];
  final List<String> _years = ['2024', '2023', '2022'];

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
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: isDark ? Colors.white : Colors.black87,
                      size: 20,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    'Exam Results',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
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
                    // Banner Image
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCR7Uq93SSnAVoyTf-Q1_fMELRUFLVzBBlLTcdhzKZ4725RkW7BSslmOCgFxinTvfCAHOyhcKw3g_-0ZQ3QTXYPOXdWvwwbTFoDfpKqg85D1_wybBBKBM-bziFlwv-KJlSy24dO_lp6Q0IxycsUcxNjfT8jEeQY9cLUrbR7RBYcDRqlAX0FO_QHqzUoc32o1lif_SGdP_8jZpMmqjtDW0wj6lrOPNggWcDfWT-iKxvh8wRT-ZjR3Z-Nwe_y7cFfSF2Rb7khe5fCW_qX',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black12, Colors.black87],
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WELCOME TO',
                              style: TextStyle(
                                color: Colors.blue.shade200,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Jamuna Cantonment Public School & College',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Search Form
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                        ),
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
                          Text(
                            'SEARCH CRITERIA',
                            style: TextStyle(
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Class',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    AppDropdown<String>(
                                      value: _selectedClass,
                                      hint: 'Select',
                                      items: _classes
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) =>
                                          setState(() => _selectedClass = val),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Year',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    AppDropdown<String>(
                                      value: _selectedYear,
                                      hint: 'Select',
                                      items: _years
                                          .map(
                                            (y) => DropdownMenuItem(
                                              value: y,
                                              child: Text(y),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) =>
                                          setState(() => _selectedYear = val),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Roll Number',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: _rollController,
                            hint: 'Enter roll number',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 24),
                          AppButton(
                            label: 'Get Result',
                            leadingIcon: Icons.search,
                            isLoading: _isLoading,
                            onPressed: () async {
                              if (_selectedClass == null ||
                                  _selectedYear == null ||
                                  _rollController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill all fields'),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                                _showResult = false;
                              });

                              // Simulate API call
                              await Future.delayed(const Duration(seconds: 1));

                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                  _showResult = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    if (_showResult) ...[
                      const SizedBox(height: 24),
                      _buildResultCard(context),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_rounded, size: 20),
                          label: const Text('Download Result PDF'),
                          style: TextButton.styleFrom(
                            foregroundColor: isDark
                                ? Colors.blue.shade200
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.05),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rahim Uddin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? Colors.blue.shade100
                            : AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: 'Roll: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                        children: [
                          TextSpan(
                            text: '101',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const TextSpan(text: ' • Class X'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Session: 2023-2024',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'GRADE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'A+',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.present,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Marks Table
          Table(
            border: TableBorder(
              horizontalInside: BorderSide(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                width: 1,
              ),
            ),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header Row
              TableRow(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      'Subject',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      'Marks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      'Grade',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              // Data Rows
              _buildTableRow(
                'Mathematics',
                '85',
                'A+',
                AppColors.present,
                isDark,
              ),
              _buildTableRow(
                'Physics',
                '78',
                'A',
                isDark ? Colors.blue.shade300 : AppColors.primary,
                isDark,
              ),
              _buildTableRow(
                'Chemistry',
                '76',
                'A',
                isDark ? Colors.blue.shade300 : AppColors.primary,
                isDark,
              ),
              _buildTableRow('English', '82', 'A+', AppColors.present, isDark),
              _buildTableRow(
                'Biology',
                '79',
                'A',
                isDark ? Colors.blue.shade300 : AppColors.primary,
                isDark,
              ),
              _buildTableRow(
                'Bangla',
                '72',
                'A-',
                isDark ? Colors.blue.shade300 : AppColors.primary,
                isDark,
              ),
            ],
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL MARKS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade100,
                      ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        text: '472 ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '/ 600',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(width: 1, height: 32, color: Colors.white24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'FINAL GPA',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade100,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '5.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  TableRow _buildTableRow(
    String subject,
    String marks,
    String grade,
    Color gradeColor,
    bool isDark,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            subject,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey.shade200 : Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            marks,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            grade,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, color: gradeColor),
          ),
        ),
      ],
    );
  }
}
