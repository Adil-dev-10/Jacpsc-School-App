import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';

class PublicGalleryScreen extends StatelessWidget {
  const PublicGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: false,
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
          preferredSize: const Size.fromHeight(50),
          child: SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildTab('All Photos', true),
                _buildTab('Campus', false),
                _buildTab('Events', false),
                _buildTab('Sports', false),
                _buildTab('Awards', false),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured Albums
              const Text(
                'Featured Albums',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _buildFeaturedAlbum(
                      context,
                      "Annual Convocation 2023",
                      "Celebrating the achievements of our graduating class.",
                      "Oct 12, 2023",
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuAsgQQ7-IyYLOXoQm-b7jyMvYtXtuyBnBCnjRSSkhxGuPGAvicZfNQq8f89sLFQzb3UUV5TDzgRKtNXuyfrvtavSnNzzJaStVIYT3ejrPtmHzUK9loqiV1RQ5KewTLl09eyEoC-S6jof9Gn9mveUEcuslVAo9NYsh1BJhOHHmRZqawknNur4TkO66ZnlksWuLfYWsfODc4XaScPNgGoUgJ2PRZyWUgfo9rBelyWEAd1qW5Q9srWvKgNb_muH1OOG35hfe3xRpr_TZSd",
                      24,
                    ),
                    const SizedBox(width: 16),
                    _buildFeaturedAlbum(
                      context,
                      "Inter-School Sports Meet",
                      "Highlights from the track and field events.",
                      "Sep 28, 2023",
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuD_HpXIpG4h3nDcbwXXMan-W0ndAjQvBk1iE8eNJHRZr3QlNFbrkzFOmxTFAXMXo43uIo9u9uPu2G1n6X5P_a43W94MrSEl9j7RJpIOxw04QDOA4mZsVIPKAzqS0vJcE1x16gd-3H32VWNRWiJrsqlqGJ-CjzkxcUbyln7Tys26xhFAoqRTkX36JDXLqad23ZK16dY6PwrHtyYJaWzvLd4z_wNzX8436tYFxWj8reuMTOq4KBJUDVghsS1BXP8k6vDVd1NglZ4EXkw1",
                      42,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Recent Uploads
              const Text(
                'Recent Uploads',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildGalleryItem(
                    context,
                    "New Science Lab",
                    "Infrastructure",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuDhC7NoRxpkrFkeG_olfxqqpCQARfMcoPc7e1C71lmzzCyARuOAtyOoSwzsd3cBORWtcNJreRMtoGQ0JGnhsUi1djO6gzeX2d7M-w_YCZPtlnjIJor4Hsm4vsDJiOI8fGOds1vosTNraSiuR1hEdH-I0P5v7uZDolaZ1Pv42MzSRM08mFIZn3gj1ugR_w00ZKlVi9X-WmeX1JXBcQqBYp5RZTL1LsTW6kJcRluayByseSqHnDf_ZQCPpRn6WayoujOoRUM-T4ImMikp",
                  ),
                  _buildGalleryItem(
                    context,
                    "Smart Classrooms",
                    "Academics",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuDqS9pYflQQuxyX8viTb-GlECibvmmWKDQnHLrlwV2XFV6KhC7CQfKxWOD_h-VbU-VIF9ANY1m9CeBCM8_4UaJC2f1mwRvy85JYQlwNJSq80_Cpf_rtNR3l34iHQaXV1G2ijE-59xcV8OnNwirSxb6ukSpKWhkBM6KMHD76vhysoDf_5t7pDChCA2Vh795m1cbrvNuT5WHIUdGUazrTcNU2Yp-H4DOHaN6DCBvhrZ8FmvOMnAq2h-loEs2Rnv9EZ6jMRXRODZJOGuhZ",
                  ),
                  _buildGalleryItem(
                    context,
                    "Library Renovation",
                    "Infrastructure",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuCffiX2lK2RQU6LqDWpo55itbWBHww0CcKbyQL_F1PgmJ0pAuBOVwCNdgolM_EyBlaNQ6tCsMw4Q5aHsqwUXjZiN8reO-AsuBZ9Np4rZ_2v5V6b2PkxLU0yE0oK7MYMRet-vfWDPqJceZMmAnc_4bQ4eKP-9SO-K5S1wzfJE6J3_z_9NyFB0d4EGLTv-Psq-WagsvohIWyqrN7T6ykFvkyXoZgZkXADH4EasBOTRXB0Goy6p9I-Q9iSn0QMn65J_nWpHC2AHpUDiurW",
                  ),
                  _buildGalleryItem(
                    context,
                    "Cultural Fest '23",
                    "Events",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuAO-pkB26mgNDGq9Yq80MbmuAM4flC4Gq5ydIjTInTHcWbspKRZlse4H8RgYRdFf5xp2pdKDvrz-sRu_bDW4-oLEujpgKqawua0nXm1wkEy1wg-ocumfndaHNo9DlkSZgf_B66fhhvm7hRwz9Vtdq0yyTV6GMR1E8q0o3N1m5CPsP6ysEorV85a18XUMqRV3zobrh7Q8sgp3VRgOilT-VBqsBkdWbicjzn14_j0CDIQpJUv6qEbeFioCE0SdceCnSa8es_nU0jW9sPk",
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "End of gallery",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAlbum(
    BuildContext context,
    String title,
    String desc,
    String date,
    String imageUrl,
    int count,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          count.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
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

  Widget _buildGalleryItem(
    BuildContext context,
    String title,
    String category,
    String imageUrl,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  category,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
