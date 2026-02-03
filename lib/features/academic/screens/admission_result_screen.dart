import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_inputs.dart';

class AdmissionResultScreen extends StatefulWidget {
  const AdmissionResultScreen({super.key});

  @override
  State<AdmissionResultScreen> createState() => _AdmissionResultScreenState();
}

class _AdmissionResultScreenState extends State<AdmissionResultScreen> {
  String? _selectedSession;
  final _rollController = TextEditingController();
  bool _isLoading = false;
  bool _showResult = false;

  final List<String> _sessions = ['2024-25', '2023-24', '2022-23'];

  @override
  void dispose() {
    _rollController.dispose();
    super.dispose();
  }

  Future<void> _searchResult() async {
    if (_selectedSession == null || _rollController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _showResult = true;
    });
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
        title: const Text('Admission Result'),
        centerTitle: true,
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.textMainLight,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Form Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white10 : Colors.grey.shade200,
                ),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: isDark ? Colors.blue[300] : AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Search Result',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your admission roll number to check your result',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Session Dropdown
                  AppDropdown<String>(
                    label: 'Session',
                    hint: 'Select session',
                    value: _selectedSession,
                    items: _sessions
                        .map(
                          (session) => DropdownMenuItem(
                            value: session,
                            child: Text(session),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedSession = value),
                  ),
                  const SizedBox(height: 16),

                  // Roll Number
                  AppTextField(
                    label: 'Roll Number',
                    hint: 'Enter your roll number',
                    controller: _rollController,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.confirmation_number_outlined,
                  ),
                  const SizedBox(height: 24),

                  // Search Button
                  AppButton(
                    label: 'Search Result',
                    leadingIcon: Icons.search,
                    isLoading: _isLoading,
                    onPressed: _searchResult,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            if (_showResult) ...[
              const SizedBox(height: 24),
              _buildResultCard(context),
            ],
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
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: isDark ? 0.2 : 0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.white10 : Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green[400],
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECTED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400],
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildDetailRow(context, 'Name', 'Rahim Uddin'),
                _buildDetailRow(context, 'Roll Number', _rollController.text),
                _buildDetailRow(context, 'Session', _selectedSession ?? ''),
                _buildDetailRow(context, 'Applied For', 'Class 6'),
                _buildDetailRow(context, 'Merit Position', '42'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: isDark ? Colors.blue[300] : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Please complete admission formalities by Dec 30, 2024',
                          style: TextStyle(
                            color: isDark
                                ? Colors.blue[200]
                                : AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: 'Download Admit Card',
                  leadingIcon: Icons.download,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Downloading admit card...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms).fadeIn();
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
