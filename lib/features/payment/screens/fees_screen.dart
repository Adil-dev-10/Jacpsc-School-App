import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Fees & Payments'),
        centerTitle: true,
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildFeesCard(
            context,
            "Tuition Fee (April)",
            "2,500 BDT",
            "Due Date: 15 Apr 2024",
            false,
          ),
          _buildFeesCard(
            context,
            "Exam Fee (Half Yearly)",
            "1,000 BDT",
            "Paid on 05 Apr 2024",
            true,
          ),
          _buildFeesCard(
            context,
            "Transport Fee (March)",
            "800 BDT",
            "Paid on 10 Mar 2024",
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildFeesCard(
    BuildContext context,
    String title,
    String amount,
    String status,
    bool isPaid,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: isPaid ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isPaid ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isPaid
                  ? Colors.grey.shade300
                  : AppColors.primary,
              foregroundColor: isPaid ? Colors.grey.shade600 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(isPaid ? 'PAID' : 'PAY NOW'),
          ),
        ],
      ),
    );
  }
}
