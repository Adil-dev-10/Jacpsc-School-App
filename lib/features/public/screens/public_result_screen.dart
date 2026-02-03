import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class PublicResultScreen extends StatefulWidget {
  const PublicResultScreen({super.key});

  @override
  State<PublicResultScreen> createState() => _PublicResultScreenState();
}

class _PublicResultScreenState extends State<PublicResultScreen> {
  final TextEditingController _searchController = TextEditingController(
    text: "1205",
  );
  bool _showResult = false;

  void _checkResult() {
    // Simulate API call or validation
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _showResult = true;
      });
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
        title: const Text('Admission Results'),
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
        child: Column(
          children: [
            // Header
            Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuCJ9rf60b0vSjkEB6gzOAXlIrvcre8-rIsBMQNyiO_Ula04GEh80PGL5psA6fs28tSV3Hp37PsKF11j2avacYcXjpK1O9ihU4Ml8E34MUNinVtxVhd5Z9Olp8jmSwcRkt1a1jcGsR1fqrioziQx2PjRff_ts_VlylNRNRZzPiUWDnhEX5k685YVlh4-A8mFrmMGYZ_0j3fMY_DFEGp52utKt33gru-5JCwgGr6zJRQ-OfIfvZmvr0dAIMfxzCKijtTwx0pxXcEq2ayk",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.school,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'JACPSC',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Session 2024-2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Form
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Check Admission Status',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your Roll Number or Application ID below to view your result.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),

                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Roll or Application ID',
                      hintText: 'Ex: 2024001',
                      prefixIcon: const Icon(Icons.tag),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _checkResult,
                    icon: const Icon(Icons.search),
                    label: const Text('Check Result'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_showResult) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'SEARCH RESULT',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),

              // Result Card
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.celebration,
                              color: Colors.green,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Congratulations!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Selected',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          _buildDetailRow(
                            context,
                            'Student Name',
                            'Sadia Rahman',
                          ),
                          _buildDetailRow(
                            context,
                            'Roll Number',
                            _searchController.text,
                          ),
                          _buildDetailRow(context, 'Group', 'Science'),
                          _buildDetailRow(context, 'Class', 'XI'),

                          const SizedBox(height: 24),

                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.description),
                            label: const Text('Admission Guidelines'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 0.2, end: 0, duration: 500.ms).fadeIn(),
            ],

            // Footer
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Need assistance with your result?',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Contact Helpline'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
