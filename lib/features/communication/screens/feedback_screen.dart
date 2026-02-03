import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String? _selectedCategory;
  final TextEditingController _messageController = TextEditingController();

  final List<String> _categories = [
    'Academic',
    'Campus Facilities',
    'Transport',
    'Food & Cafeteria',
    'Library',
    'Sports',
    'Administration',
    'Other',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_selectedCategory == null || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to thank you page
    context.push('/app/feedback/thankyou');
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
            color: isDark ? Colors.white : AppColors.primary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Feedback',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon and Title Section
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'JACPSC Feedback',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We value your thoughts to improve our campus experience.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // Subject Dropdown
            Text(
              'Subject',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: Text(
                    'Select a category',
                    style: TextStyle(
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade500,
                    ),
                  ),
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.surfaceDark : Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategory = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Message Field
            Text(
              'Message',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 6,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Describe your feedback in detail...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Attachment Section
            Text(
              'Attachment (Optional)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image picker coming soon...')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 32,
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload screenshot or image',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
