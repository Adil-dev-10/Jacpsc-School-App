import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';

class CreateNewGroupScreen extends StatefulWidget {
  const CreateNewGroupScreen({super.key});

  @override
  State<CreateNewGroupScreen> createState() => _CreateNewGroupScreenState();
}

class _CreateNewGroupScreenState extends State<CreateNewGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedMembers = {};

  // Mock data for members
  final List<Map<String, dynamic>> _allMembers = [
    {
      'id': 'ahmed_hossain',
      'name': 'Mr. Ahmed Hossain',
      'role': 'Senior Teacher, Math Dept.',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDhC7NoRxpkrFkeG_olfxqqpCQARfMcoPc7e1C71lmzzCyARuOAtyOoSwzsd3cBORWtcNJreRMtoGQ0JGnhsUi1djO6gzeX2d7M-w_YCZPtlnjIJor4Hsm4vsDJiOI8fGOds1vosTNraSiuR1hEdH-I0P5v7uZDolaZ1Pv42MzSRM08mFIZn3gj1ugR_w00ZKlVi9X-WmeX1JXBcQqBYp5RZTL1LsTW6kJcRluayByseSqHnDf_ZQCPpRn6WayoujOoRUM-T4ImMikp',
    },
    {
      'id': 'nafisa_tabassum',
      'name': 'Nafisa Tabassum',
      'role': 'Student, Class 10 (Jasmine)',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD_HpXIpG4h3nDcbwXXMan-W0ndAjQvBk1iE8eNJHRZr3QlNFbrkzFOmxTFAXMXo43uIo9u9uPu2G1n6X5P_a43W94MrSEl9j7RJpIOxw04QDOA4mZsVIPKAzqS0vJcE1x16gd-3H32VWNRWiJrsqlqGJ-CjzkxcUbyln7Tys26xhFAoqRTkX36JDXLqad23ZK16dY6PwrHtyYJaWzvLd4z_wNzX8436tYFxWj8reuMTOq4KBJUDVghsS1BXP8k6vDVd1NglZ4EXkw1',
    },
    {
      'id': 'fahim_muntassir',
      'name': 'Fahim Muntassir',
      'role': 'Student, Class 10 (Lotus)',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsgQQ7-IyYLOXoQm-b7jyMvYtXtuyBnBCnjRSSkhxGuPGAvicZfNQq8f89sLFQzb3UUV5TDzgRKtNXuyfrvtavSnNzzJaStVIYT3ejrPtmHzUK9loqiV1RQ5KewTLl09eyEoC-S6jof9Gn9mveUEcuslVAo9NYsh1BJhOHHmRZqawknNur4TkO66ZnlksWuLfYWsfODc4XaScPNgGoUgJ2PRZyWUgfo9rBelyWEAd1qW5Q9srWvKgNb_muH1OOG35hfe3xRpr_TZSd',
    },
    {
      'id': 'salma_begum',
      'name': 'Mrs. Salma Begum',
      'role': 'Coordinator, JACPSC',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6udqjIPfxMy6En0WoA4rvcbMyU-T8nJ4jtstYr5mp3YWJSNwQuLHTvdJozaIIH9eCgWZ27XW5ubLYScAWx0tD_Ux_-mOlaaShsEJTtUA1iCXQzBhQ0KA268sr0slxoSCU_U0AAEkdows7DDxqO6BNCNcyzF-YsgBVcRUslouzKjTdbfdaq_V2GzvBaifBKL6d3ZKYsNLmpNlfxO7Sia8Mc6I7pkDVMpi7MVdThwFUNfh0tRv8srcBUsYNR5TiPukbrT02Lw-ScSmg',
    },
  ];

  // Pre-selected members for display
  final List<Map<String, dynamic>> _preSelectedMembers = [
    {
      'id': 'rahat_10a',
      'name': 'Rahat (10A)',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAsgQQ7-IyYLOXoQm-b7jyMvYtXtuyBnBCnjRSSkhxGuPGAvicZfNQq8f89sLFQzb3UUV5TDzgRKtNXuyfrvtavSnNzzJaStVIYT3ejrPtmHzUK9loqiV1RQ5KewTLl09eyEoC-S6jof9Gn9mveUEcuslVAo9NYsh1BJhOHHmRZqawknNur4TkO66ZnlksWuLfYWsfODc4XaScPNgGoUgJ2PRZyWUgfo9rBelyWEAd1qW5Q9srWvKgNb_muH1OOG35hfe3xRpr_TZSd',
    },
    {
      'id': 'ms_mina',
      'name': 'Ms. Mina',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD_HpXIpG4h3nDcbwXXMan-W0ndAjQvBk1iE8eNJHRZr3QlNFbrkzFOmxTFAXMXo43uIo9u9uPu2G1n6X5P_a43W94MrSEl9j7RJpIOxw04QDOA4mZsVIPKAzqS0vJcE1x16gd-3H32VWNRWiJrsqlqGJ-CjzkxcUbyln7Tys26xhFAoqRTkX36JDXLqad23ZK16dY6PwrHtyYJaWzvLd4z_wNzX8436tYFxWj8reuMTOq4KBJUDVghsS1BXP8k6vDVd1NglZ4EXkw1',
    },
    {
      'id': 'sajid',
      'name': 'Sajid',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDhC7NoRxpkrFkeG_olfxqqpCQARfMcoPc7e1C71lmzzCyARuOAtyOoSwzsd3cBORWtcNJreRMtoGQ0JGnhsUi1djO6gzeX2d7M-w_YCZPtlnjIJor4Hsm4vsDJiOI8fGOds1vosTNraSiuR1hEdH-I0P5v7uZDolaZ1Pv42MzSRM08mFIZn3gj1ugR_w00ZKlVi9X-WmeX1JXBcQqBYp5RZTL1LsTW6kJcRluayByseSqHnDf_ZQCPpRn6WayoujOoRUM-T4ImMikp',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Pre-select some members
    _selectedMembers.add('nafisa_tabassum');
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _createGroup() {
    if (_groupNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a group name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Group created successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    context.pop();
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
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Create New Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group Photo Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark.withValues(alpha: 0.5)
                          : Colors.grey.shade100,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade300,
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: isDark
                                    ? Colors.grey.shade500
                                    : AppColors.primary,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Group Photo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Identification for JACPSC portal',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Group Name Input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Group Name',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _groupNameController,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. Science Project - Grade 10',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: isDark
                                ? AppColors.surfaceDark
                                : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Add Members Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Add Members',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Selected Members Chips
                  SizedBox(
                    height: 45,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _preSelectedMembers.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final member = _preSelectedMembers[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceDark
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: CachedNetworkImageProvider(
                                  member['imageUrl'],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                member['name'],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.close,
                                size: 16,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search students or faculty...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade500,
                        ),
                        filled: true,
                        fillColor: isDark
                            ? AppColors.surfaceDark
                            : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Member List with Checkboxes
                  ..._allMembers.map(
                    (member) => _buildMemberItem(member, isDark),
                  ),
                ],
              ),
            ),
          ),

          // Create Group Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.backgroundDark : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createGroup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create Group',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem(Map<String, dynamic> member, bool isDark) {
    final isSelected = _selectedMembers.contains(member['id']);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedMembers.remove(member['id']);
          } else {
            _selectedMembers.add(member['id']);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: CachedNetworkImageProvider(member['imageUrl']),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    member['role'],
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
