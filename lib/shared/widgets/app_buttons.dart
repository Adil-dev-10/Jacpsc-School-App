import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// A primary elevated button styled according to the app design system.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                isOutlined ? AppColors.primary : Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        if (leadingIcon != null && !isLoading) ...[
          Icon(leadingIcon, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          Icon(trailingIcon, size: 20),
        ],
      ],
    );

    if (isOutlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(
              color: isDark ? Colors.white30 : AppColors.primary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: buttonChild,
        ),
      );
    }

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 0,
        ),
        child: buttonChild,
      ),
    );
  }
}

/// A small button variant, often used for secondary actions or chips.
class AppSmallButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;

  const AppSmallButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color:
          backgroundColor ?? (isDark ? Colors.white10 : Colors.grey.shade100),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: foregroundColor ?? AppColors.primary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor ?? AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// An icon button with a circular tap area.
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final int? badgeCount;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color:
              backgroundColor ??
              (isDark ? Colors.white10 : Colors.grey.shade100),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: iconColor ?? (isDark ? Colors.white : AppColors.primary),
                size: size * 0.55,
              ),
            ),
          ),
        ),
        if (badgeCount != null && badgeCount! > 0)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                badgeCount! > 9 ? '9+' : badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
