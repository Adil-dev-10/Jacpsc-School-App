import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class PublicFacultyScreen extends StatelessWidget {
  const PublicFacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Teachers & Staff'),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by name or department...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: isDark
                          ? AppColors.backgroundDark
                          : AppColors.backgroundLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.backgroundDark
                        : AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 32,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterChip('All', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Administration', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Science', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Arts', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Support', false),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSectionTitle(context, 'Administration'),
                _buildStaffCard(
                  context,
                  "Dr. Md. Rafiqul",
                  "Islam",
                  "Principal",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAwUxFQxDx7MpvyopUrbON50lgaxGFD1nHWPJkW8m0IUvY0UU4aQcTUyi3HP0n9_SzhGPk02bO7XQT9g3GRohg8nAztYWd8i_dj-v8uwbgxwdWz4OrwDUZnPWS7h4Czgv11waealh3D0R-xXifuif_f1eEpt_zKaosGmMq8BAkHoYknbZ3v7oobZNWTqEaR2mGqs0ymV_w140y3G45_8P45hQ2RR38dYIEDKFjUVTrIhr74R2JKRUooR6F_qPUYjlv5ZrHJpwt1esjn",
                  Icons.call,
                ),
                _buildStaffCard(
                  context,
                  "Mrs. Salma",
                  "Begum",
                  "Vice Principal",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCV8vlPxDGHJGtF7Ty1HKZrA0ETDU-YNJcBu4egT7zvPg44iTJECyLTLWGmfZvI8Fx5vcMgFfyCL404zmilelT6G20XmvwBrKYVFPnD6jHR0tBzkJM00NA3sKLIk8n28ESNl7oKJKNpNfr-DlMstXR4I0mE3Yb2MIkb6UzxbLq0GV_rNg9tNuqhABgidWUcGHKKVg71QJ9KiddWhjb6_5KyJR46JncFmBwON6spEZHDnZWyeZwURYix1BiZrrj9ztI8UKAvk67Dx9zX",
                  Icons.mail,
                ),

                _buildSectionTitle(context, 'Science Department'),
                _buildStaffCard(
                  context,
                  "Mr. Ahmed",
                  "Khan",
                  "Senior Lecturer, Physics",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCgcEeNDB3UU4VgewfvEGjU47_LSEbshb_whcl-XGJT9e4D9B3o5kghlIwIL93P2th3cLdfNJsvGsxCNX-OQ5_d2cEIKJl4PLdtHzlW7uQ4cpFw1D7msU4EmVOGZaa-dgOV_qXC_y1tYyNpOdpO_dW9G0av3ofq0t87PkQX1G2o8uafMqCoSdylkwxY90HpH-0Ek3hqMg4LWtLMeTNQnWCgtzTtKbZqurATdGvT-UAN510NKLY7AshEibnNVuLCbMAiyv83m0FBmTHP",
                  Icons.call,
                ),
                _buildStaffCard(
                  context,
                  "Ms. Farhana",
                  "Karim",
                  "Lecturer, Chemistry",
                  null, // No image, simulates initials
                  Icons.mail,
                ),
                _buildStaffCard(
                  context,
                  "Dr. Anisur",
                  "Rahman",
                  "Asst. Professor, Biology",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCB1qOm5td2azmSb3GbJzRlO7pdBGJgTOkTa4Lrv0VPsTWYNb4Hs94gxtRU-HWg0OJLxbudHZZhel_AdAeu7CBBRHVnPcB8DoqMhXpkCX0CSKp67V-kRYAP4WahH1sPuMZo900dXF4m57k6AIpzqf6xGMtoV-zMujUt8ZAEENNOLRULQ0WU-5auhnPqKdTTxZ9jMGZSBN4l3dXmadi11hFrHPzBEtwdGNWXItE-EFV59ssXSLu1NTQsdYDKJ6DoP1g72Piv1ycn7F_Y",
                  Icons.call,
                ),

                _buildSectionTitle(context, 'Arts & Humanities'),
                _buildStaffCard(
                  context,
                  "Mrs. Sarah",
                  "Jenkins",
                  "Lecturer, English Literature",
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCkJVRLluBfar6ol9ZK7KC6_r0TfygFEZQRnqsCHtzU07sfbsd5SBJ65-jzVDCPghbWZkYHsRI4hXKITBfPsgowjx6YQVuBS-2ycsQMUhX-tcKFw7yKYANbJUuvgIhKZ9qEY3rR2fLau-4vY0AOu85Kh3cAuDIZVKIlIKf5BkMNjTA7Zdc9z9iPuRzKII5G_VQAIeEFbbiFB-3BOIT1nvDfMDbq-_lV1DkUfe7gdH9QdiUvK0tPsCQLhIBt6cJp-nU2mZmJy0XDkvY-",
                  Icons.mail,
                ),
              ],
            ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey[300]!,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildStaffCard(
    BuildContext context,
    String firstName,
    String lastName,
    String role,
    String? imageUrl,
    IconData actionIcon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (imageUrl != null)
            CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl))
          else
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                "${firstName[0]}${lastName[0]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),

          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstName $lastName",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(actionIcon, color: AppColors.primary),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
