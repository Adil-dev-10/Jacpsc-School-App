import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_inputs.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  String _selectedClass = 'Class 9 (Science)';
  final List<String> _classes = [
    'Class 9 (Science)',
    'Class 9 (Arts)',
    'Class 9 (Commerce)',
    'Class 8',
    'Class 7',
  ];

  final List<Map<String, dynamic>> _books = [
    {
      'title': 'Oxford Reading Circle',
      'author': 'Nicholas Horsburgh',
      'publisher': 'Oxford University Press',
      'subject': 'English',
      'subjectColor': Colors.blue,
      'isRequired': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBR2MuoH9Zsl4z3cH8SzEVTJWDJgbwlC1wZdqdUaJ3cw_4Y5oT_GMz-btmWRlQGtz_LXXTn9XuhGrv5F2q5jwqbb3hnfemHzSu0ST1wDruJuXY1y9NflnrCHtDttCiNncRnn_WQJCEH4Sm8QZnPu4vLWZ7_LliK4ikPlGPQh9Fan82W7nVgLBYSHRV9SnmPkel9yNcJTaiCAubgBH1ylskOfnDof8ggm2C15GvVYHmcYhyYnOVAwn4p5jvmGpS2Qw_3ioP2wC7_AknB',
    },
    {
      'title': 'Higher Mathematics',
      'author': 'Dr. M. A. Jalil',
      'publisher': 'Approved by NCTB',
      'subject': 'Mathematics',
      'subjectColor': Colors.orange,
      'isRequired': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAecLDj4RtsOxW4-XwI79MHiYWVWJZ_BMA3bnImmqPq2h9UmbxXATjYnxKJOUdu5VQU7merpl-Ky6Rm5tslk1Qb_AeH7TMYXAUHsI4eTmfLW3PZaCQEJCxtZAxTZhGFLyezeKTgL6FVUClcCn5jUk0_wiDDUcX9somOm9_9zTp547leC8DiUM3qYUe9ppK0DEsD_5iy5MRrjuW5C5Ez-imD0RYch4WyGKK5JW5FUCyx5r2TGyDiH78UKIIlrwVoiXKlF-KACJuSf6rg',
    },
    {
      'title': 'Secondary Physics',
      'author': 'Dr. Shahjahan Tapan',
      'publisher': 'Hassan Book House',
      'subject': 'Physics',
      'subjectColor': Colors.purple,
      'isRequired': true,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAml51oq2hd9Hi9KrnpuNIEmw-A4oJrxzqdr2rIrpCsN4UZH3IovNN-qd4nDT8iltzFh8-63zcwmjyWZc8GXtue_kWmEqXgasKDVTROETEH5p_fck3g9ASnjo-9JWkeiuxqDD7u2yGAa1x-jAQQ8SBKohpijAAhq6qOa_2actdS3VwxkiNMeuB_f1d0iu7HyPY6aQpaF2sspikiTUKXC33xf2cPP0G8-08GzjQbjcNn2wSmJ4K7x5r-QxaLjNFBvUXB91AMqZVbtcU0',
    },
    {
      'title': 'Advanced Chemistry',
      'author': 'Hajara & Kabir',
      'publisher': 'Approved by NCTB',
      'subject': 'Chemistry',
      'subjectColor': Colors.pink,
      'isRequired': false,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBexd0PoP9bF8B4SGEKgiExVjmH41K2sh6iPOCCtyflhplMLvfQ3N8aOw1ULwPdxO-MYRaTP6KTeNJfwD_21TPdR-AlHdjPlwXPi-hh955cyeolYZoyRb-1XMQFSWIPrSC_bVxfDoXiOe0nt-LKovrpnA_zbx3Jb-ZRgDz4EC15uT47dllgaWvm7YX7MqTIWVkIS9ROQeP00YnjDxM9bqn7-xqdxrk51T3yfIG2RtEISPzOiUd4fU5iBX7ZvjqYHM9u2vQwEaXcV3pO',
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
          children: [
            // Header
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Book List',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () {}, // Filter action
                  ),
                ],
              ),
            ),

            // Sticky Class Selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  ),
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
                    'SELECT CLASS',
                    style: TextStyle(
                      color: isDark ? Colors.grey.shade300 : AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppDropdown<String>(
                    value: _selectedClass,
                    items: _classes
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedClass = val);
                    },
                  ),
                ],
              ),
            ),

            // Book List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Required Textbooks',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.primary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_books.length} Books',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.blue.shade200
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        return _buildBookCard(context, _books[index]);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'Showing ${_books.length} books',
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80), // Fab space
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.download, color: Colors.white),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, Map<String, dynamic> book) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectColor = book['subjectColor'] as Color;
    final isRequired = book['isRequired'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              image: DecorationImage(
                image: CachedNetworkImageProvider(book['imageUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: subjectColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: subjectColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    book['subject'],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.primary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  book['author'],
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  book['publisher'],
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade400,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 70), // Push badge to bottom
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isRequired
                      ? AppColors.present.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isRequired ? 'REQUIRED' : 'OPTIONAL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isRequired
                        ? AppColors.present
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
