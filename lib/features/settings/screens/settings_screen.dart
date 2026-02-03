import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/theme/language_provider.dart';
import '../../auth/services/auth_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(t(ref, 'settings')),
        centerTitle: true,
        backgroundColor: isDark ? AppColors.primary : AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Account Settings
          _buildSectionHeader(context, t(ref, 'account')),
          _buildSettingsGroup(context, [
            _SettingsTile(
              icon: Icons.shield_outlined,
              title: t(ref, 'security'),
              onTap: () => _showPlaceholderDialog(context, t(ref, 'security')),
            ),
            _SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: t(ref, 'notifications'),
              onTap: () =>
                  _showPlaceholderDialog(context, t(ref, 'notifications')),
            ),
          ]),

          const SizedBox(height: 24),

          // App Settings
          _buildSectionHeader(context, t(ref, 'appSettings')),
          _buildSettingsGroup(context, [
            _SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: t(ref, 'darkMode'),
              trailing: Switch.adaptive(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  ref
                      .read(themeProvider.notifier)
                      .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                },
                activeTrackColor: AppColors.primary,
              ),
            ),
            _SettingsTile(
              icon: Icons.translate,
              title: t(ref, 'language'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    locale.languageCode == 'bn' ? 'বাংলা' : 'English',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),
              onTap: () => _showLanguageDialog(context, ref),
            ),
            _SettingsTile(
              icon: Icons.format_size,
              title: t(ref, 'fontSize'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Medium',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),
              onTap: () => _showFontSizeDialog(context),
            ),
          ]),

          const SizedBox(height: 24),

          // About
          _buildSectionHeader(context, t(ref, 'about')),
          _buildSettingsGroup(context, [
            _SettingsTile(
              icon: Icons.policy_outlined,
              title: t(ref, 'privacyPolicy'),
              onTap: () =>
                  _showPlaceholderDialog(context, t(ref, 'privacyPolicy')),
            ),
            _SettingsTile(
              icon: Icons.description_outlined,
              title: t(ref, 'termsOfService'),
              onTap: () =>
                  _showPlaceholderDialog(context, t(ref, 'termsOfService')),
            ),
            _SettingsTile(
              icon: Icons.info_outline,
              title: t(ref, 'appVersion'),
              trailing: Text(
                'v1.0.2',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ),
          ]),

          const SizedBox(height: 32),

          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton.icon(
              onPressed: () => _showLogoutDialog(context, ref),
              icon: const Icon(Icons.logout),
              label: Text(t(ref, 'logOut')),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
                foregroundColor: Colors.red,
                elevation: 0,
                side: BorderSide(color: Colors.red.withValues(alpha: 0.2)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
          Center(
            child: Text(
              'JACPSC Student App © 2024',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade400
              : Colors.grey.shade600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<_SettingsTile> tiles) {
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
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: tiles.asMap().entries.map((entry) {
          final index = entry.key;
          final tile = entry.value;

          return Column(
            children: [
              ListTile(
                onTap: tile.onTap,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    tile.icon,
                    color: isDark ? Colors.blue.shade300 : AppColors.primary,
                    size: 20,
                  ),
                ),
                title: Text(
                  tile.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                trailing:
                    tile.trailing ??
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 20,
                    ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
              if (index != tiles.length - 1)
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.grey.shade100,
                  indent: 60,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(t(ref, 'logOut')),
        content: Text(t(ref, 'logOutConfirmation')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              t(ref, 'cancel'),
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
              context.go('/landing');
            },
            child: Text(
              t(ref, 'confirmLogOut'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(t(ref, 'language')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: ref.watch(localeProvider).languageCode == 'en'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(localeEnglish);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('বাংলা'),
              trailing: ref.watch(localeProvider).languageCode == 'bn'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(localeBangla);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    // Placeholder for font size selection
    _showPlaceholderDialog(context, 'Font Size Adjustment');
  }

  void _showPlaceholderDialog(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: Text(title),
        content: const Text('This feature is coming soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });
}
