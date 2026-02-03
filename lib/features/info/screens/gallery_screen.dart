import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String _selectedCategory = 'All Photos';
  final List<String> _categories = [
    'All Photos',
    'Campus',
    'Events',
    'Sports',
    'Awards',
  ];

  final List<Map<String, dynamic>> _featuredAlbums = [
    {
      'title': 'Annual Convocation 2023',
      'description': 'Celebrating the achievements of our graduating class.',
      'date': 'Oct 12, 2023',
      'itemCount': 24,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsgQQ7-IyYLOXoQm-b7jyMvYtXtuyBnBCnjRSSkhxGuPGAvicZfNQq8f89sLFQzb3UUV5TDzgRKtNXuyfrvtavSnNzzJaStVIYT3ejrPtmHzUK9loqiV1RQ5KewTLl09eyEoC-S6jof9Gn9mveUEcuslVAo9NYsh1BJhOHHmRZqawknNur4TkO66ZnlksWuLfYWsfODc4XaScPNgGoUgJ2PRZyWUgfo9rBelyWEAd1qW5Q9srWvKgNb_muH1OOG35hfe3xRpr_TZSd',
    },
    {
      'title': 'Inter-School Sports Meet',
      'description': 'Highlights from the track and field events.',
      'date': 'Sep 28, 2023',
      'itemCount': 42,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD_HpXIpG4h3nDcbwXXMan-W0ndAjQvBk1iE8eNJHRZr3QlNFbrkzFOmxTFAXMXo43uIo9u9uPu2G1n6X5P_a43W94MrSEl9j7RJpIOxw04QDOA4mZsVIPKAzqS0vJcE1x16gd-3H32VWNRWiJrsqlqGJ-CjzkxcUbyln7Tys26xhFAoqRTkX36JDXLqad23ZK16dY6PwrHtyYJaWzvLd4z_wNzX8436tYFxWj8reuMTOq4KBJUDVghsS1BXP8k6vDVd1NglZ4EXkw1',
    },
  ];

  final List<Map<String, dynamic>> _recentUploads = [
    {
      'title': 'New Science Lab',
      'category': 'Infrastructure',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDhC7NoRxpkrFkeG_olfxqqpCQARfMcoPc7e1C71lmzzCyARuOAtyOoSwzsd3cBORWtcNJreRMtoGQ0JGnhsUi1djO6gzeX2d7M-w_YCZPtlnjIJor4Hsm4vsDJiOI8fGOds1vosTNraSiuR1hEdH-I0P5v7uZDolaZ1Pv42MzSRM08mFIZn3gj1ugR_w00ZKlVi9X-WmeX1JXBcQqBYp5RZTL1LsTW6kJcRluayByseSqHnDf_ZQCPpRn6WayoujOoRUM-T4ImMikp',
    },
    {
      'title': 'Smart Classrooms',
      'category': 'Academics',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDqS9pYflQQuxyX8viTb-GlECibvmmWKDQnHLrlwV2XFV6KhC7CQfKxWOD_h-VbU-VIF9ANY1m9CeBCM8_4UaJC2f1mwRvy85JYQlwNJSq80_Cpf_rtNR3l34iHQaXV1G2ijE-59xcV8OnNwirSxb6ukSpKWhkBM6KMHD76vhysoDf_5t7pDChCA2Vh795m1cbrvNuT5WHIUdGUazrTcNU2Yp-H4DOHaN6DCBvhrZ8FmvOMnAq2h-loEs2Rnv9EZ6jMRXRODZJOGuhZ',
    },
    {
      'title': 'Library Renovation',
      'category': 'Infrastructure',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCffiX2lK2RQU6LqDWpo55itbWBHww0CcKbyQL_F1PgmJ0pAuBOVwCNdgolM_EyBlaNQ6tCsMw4Q5aHsqwUXjZiN8reO-AsuBZ9Np4rZ_2v5V6b2PkxLU0yE0oK7MYMRet-vfWDPqJceZMmAnc_4bQ4eKP-9SO-K5S1wzfJE6J3_z_9NyFB0d4EGLTv-Psq-WagsvohIWyqrN7T6ykFvkyXoZgZkXADH4EasBOTRXB0Goy6p9I-Q9iSn0QMn65J_nWpHC2AHpUDiurW',
    },
    {
      'title': 'Cultural Fest \'23',
      'category': 'Events',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAO-pkB26mgNDGq9Yq80MbmuAM4flC4Gq5ydIjTInTHcWbspKRZlse4H8RgYRdFf5xp2pdKDvrz-sRu_bDW4-oLEujpgKqawua0nXm1wkEy1wg-ocumfndaHNo9DlkSZgf_B66fhhvm7hRwz9Vtdq0yyTV6GMR1E8q0o3N1m5CPsP6ysEorV85a18XUMqRV3zobrh7Q8sgp3VRgOilT-VBqsBkdWbicjzn14_j0CDIQpJUv6qEbeFioCE0SdceCnSa8es_nU0jW9sPk',
    },
    {
      'title': 'New Transport Fleet',
      'category': 'Facility',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD1XEHINpiUBNL5nli5p-pAu1D3xiRVKmPxBAaRlTSgDN-zwJHeN9Sr-3li08Me3ZvTbsR2z7b4-r0GKp3UMcO-4fxrdPf7feE1UaoxjBCIX41wiNpxLnCUhLQYMwPW6SS7JTlhu26a8YHSsV8CYbi76APPSw0V24gXfCGU6-G8OgCNSVUl6_m9HK9kEvqoxcy1imusMoMOzjCAVjAUCh-WyfftWLmfPpOR9hYJ1JaZPXSHNkiOqJvkDENVOH1XsgcEWHuI4Nmomyp0',
    },
    {
      'title': 'Art Competition',
      'category': 'Co-curricular',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAv89URhbTcar8Legx-7pxlMk9sFCfNbZmlxliA2WJRAxOoH6sMKNe8qjzy4Ord6rYkviFgZrtEbg1cwtKUKdKFAYNG7zewc5xW-3qY50lz_j7tF3a08fV8iy92WoFMOxpcYRspGQiKbJ5jWkA4zx1nvwpLaAz8la3J2f7jF5ndoqpiFZo05ySE6Z2ScKsRZF_Gm3OwlOsRkd8DGGtqV6qTl0tA288x0mS-F85oW2poe_ZthIJvwSruX0aVOE9DSvI_pMkwHC7B-rG_',
    },
  ];

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: isDark ? Colors.white : AppColors.primary,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = category),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Column(
                              children: [
                                Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? (isDark
                                              ? Colors.blue.shade200
                                              : AppColors.primary)
                                        : (isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade500),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (isSelected)
                                  Container(
                                    height: 2,
                                    width: 20,
                                    color: isDark
                                        ? Colors.blue.shade200
                                        : AppColors.primary,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Albums
                    Text(
                      'Featured Albums',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _featuredAlbums.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final album = _featuredAlbums[index];
                          return Container(
                            width: 280,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.surfaceDark
                                  : Colors.white,
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
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          album['imageUrl'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(16),
                                                ),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black.withValues(
                                                  alpha: 0.6,
                                                ),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
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
                                              color: Colors.black.withValues(
                                                alpha: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.photo_library,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${album['itemCount']}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          album['title'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          album['description'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isDark
                                                ? Colors.grey.shade400
                                                : Colors.grey.shade500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 12,
                                              color: isDark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade400,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              album['date'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isDark
                                                    ? Colors.grey.shade500
                                                    : Colors.grey.shade400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Recent Uploads
                    Text(
                      'Recent Uploads',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _recentUploads.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.85,
                          ),
                      itemBuilder: (context, index) {
                        final photo = _recentUploads[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        photo['imageUrl'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        photo['title'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        photo['category'],
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'End of gallery',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
