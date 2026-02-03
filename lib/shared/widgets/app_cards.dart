import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// A standard card component matching the app's design system.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final bool hasBorder;
  final bool hasShadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.hasBorder = true,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color:
            backgroundColor ?? (isDark ? AppColors.surfaceDark : Colors.white),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: hasBorder
            ? Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200)
            : null,
        boxShadow: hasShadow && !isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius:
              (borderRadius ?? BorderRadius.circular(16)) as BorderRadius?,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A list tile card for displaying items with leading icon/avatar and trailing action.
class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? leadingBackgroundColor;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding,
    this.leadingBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      padding: padding ?? const EdgeInsets.all(12),
      onTap: onTap,
      child: Row(
        children: [
          if (leading != null) ...[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:
                    leadingBackgroundColor ??
                    (isDark ? Colors.white10 : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: leading),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );
  }
}

/// A stat card for displaying statistics (e.g., attendance percentage).
class AppStatCard extends StatelessWidget {
  final String value;
  final String label;
  final String? suffix;
  final Color? valueColor;
  final IconData? icon;
  final bool isPrimary;

  const AppStatCard({
    super.key,
    required this.value,
    required this.label,
    this.suffix,
    this.valueColor,
    this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color =
        valueColor ?? (isPrimary ? AppColors.primary : AppColors.present);

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                  height: 1.0,
                ),
              ),
              if (suffix != null)
                Text(
                  suffix!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A section header with title and optional action button.
class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final EdgeInsetsGeometry? padding;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionLabel!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
