import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class AdmissionInfoScreen extends StatelessWidget {
  const AdmissionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Admission Info'),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Image
            Container(
              height: 220,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuB4eyFjp6r9pvbmgE6thslr27s_COHffndCQ7i4qT4F6w0ULksf2B_caBM7CsFu-OuIcDCeZbqLSbLCBu_llsp-0pQbK3Nf_Cgz-VxiAWa8LGrUiW8op1ABwmr7elbFytEuHvwUV5xOu9paDLmksM_RWUhP-r_plcrOdA-P5522kCRroz0UuKXLjs6LBVrj3joPTIuHkJpfyN_45fJNrNcydu8KpdbQht6nA6Jje0SRTWEGm4VthxXIj3slsuZYd0LR_I6Y34_WGUmN",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Text(
                          'Session 2024-25',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Welcome to JACPSC',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Build your future with excellence',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(),

            // Headline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join JACPSC',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We are accepting applications for the upcoming academic session. Review the requirements below and start your journey with us.',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Application Portal Opening Soon"),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_document),
                    label: const Text('Apply Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/app/admission-result'),
                    icon: const Icon(Icons.search),
                    label: const Text('Check Admission Result'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark
                          ? Colors.white
                          : AppColors.primary,
                      side: BorderSide(
                        color: isDark
                            ? Colors.grey[700]!
                            : AppColors.primary.withValues(alpha: 0.2),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            // Important Dates
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                color: isDark ? AppColors.surfaceDark : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isDark ? Colors.white10 : Colors.grey[100]!,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: isDark
                                ? Colors.blue[300]
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Important Dates',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTimelineItem(
                        context,
                        'Oct 15, 2024',
                        'Application Opens',
                        true,
                      ),
                      _buildTimelineItem(
                        context,
                        'Nov 30, 2024',
                        'Submission Deadline',
                        false,
                      ),
                      _buildTimelineItem(
                        context,
                        'Dec 15, 2024',
                        'Admission Test',
                        false,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms),

            const SizedBox(height: 24),

            // Requirements
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Requirements',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildRequirementCard(
                    context,
                    'Class 6',
                    'Age: 11+',
                    [
                      'PSC Certificate (Original & Copy)',
                      'Birth Certificate (Online copy)',
                      '2 Passport size photos',
                    ],
                    Icons.school,
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildRequirementCard(
                    context,
                    'Class 11',
                    'GPA: 4.5+',
                    ['SSC Transcript & Testimonial', 'Parents NID Copy'],
                    Icons.menu_book,
                    Colors.purple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Fees Teaser
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tuition & Fees',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'View the complete fee structure for the 2024-25 session.',
                            style: TextStyle(
                              color: Colors.blue[100],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Footer Help
            Container(
              padding: const EdgeInsets.all(24),
              color: isDark ? Colors.black12 : Colors.grey[50],
              child: Column(
                children: [
                  Text(
                    'Need help with admission?',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFooterButton(context, Icons.call, 'Call Office'),
                      const SizedBox(width: 16),
                      _buildFooterButton(context, Icons.download, 'Prospectus'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String date,
    String title,
    bool isCompleted, {
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  border: Border.all(
                    color: isCompleted ? AppColors.primary : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: Colors.grey[300])),
            ],
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? AppColors.primary : Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementCard(
    BuildContext context,
    String title,
    String badge,
    List<String> items,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[100]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green[400], size: 16),
                  const SizedBox(width: 8),
                  Text(
                    item,
                    style: TextStyle(
                      color: isDark ? Colors.grey[300] : Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(BuildContext context, IconData icon, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.grey[300] : Colors.grey[700],
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        side: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
