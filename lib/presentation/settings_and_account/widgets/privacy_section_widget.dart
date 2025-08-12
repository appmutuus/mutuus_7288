import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PrivacySectionWidget extends StatelessWidget {
  final VoidCallback? onDataExportTap;
  final VoidCallback? onAccountDeletionTap;
  final VoidCallback? onVisibilityControlsTap;
  final bool profileVisible;
  final bool leaderboardVisible;

  const PrivacySectionWidget({
    super.key,
    this.onDataExportTap,
    this.onAccountDeletionTap,
    this.onVisibilityControlsTap,
    this.profileVisible = true,
    this.leaderboardVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Text(
              'Datenschutz',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
          _buildPrivacyItem(
            context,
            icon: 'download',
            title: 'Daten exportieren',
            subtitle: 'DSGVO-konforme Datenexport',
            onTap: onDataExportTap,
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.tertiary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'DSGVO',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _buildDivider(),
          _buildPrivacyItem(
            context,
            icon: 'visibility',
            title: 'Sichtbarkeitseinstellungen',
            subtitle: 'Profil- und Ranglisten-Sichtbarkeit',
            onTap: onVisibilityControlsTap,
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.3.h),
                  decoration: BoxDecoration(
                    color: profileVisible
                        ? AppTheme.lightTheme.colorScheme.tertiary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Profil: ${profileVisible ? "Sichtbar" : "Privat"}',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: profileVisible
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.outline,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                SizedBox(height: 0.5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.3.h),
                  decoration: BoxDecoration(
                    color: leaderboardVisible
                        ? AppTheme.lightTheme.colorScheme.tertiary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Rangliste: ${leaderboardVisible ? "Teilnehmen" : "Opt-out"}',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: leaderboardVisible
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.outline,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildDivider(),
          _buildPrivacyItem(
            context,
            icon: 'delete_forever',
            title: 'Konto löschen',
            subtitle: 'Permanente Kontolöschung',
            onTap: onAccountDeletionTap,
            isDestructive: true,
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.error
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Permanent',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyItem(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: isDestructive
                    ? AppTheme.lightTheme.colorScheme.error
                        .withValues(alpha: 0.1)
                    : AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: icon,
                  color: isDestructive
                      ? AppTheme.lightTheme.colorScheme.error
                      : AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDestructive
                          ? AppTheme.lightTheme.colorScheme.error
                          : AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                CustomIconWidget(
                  iconName: 'chevron_right',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 17.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppTheme.lightTheme.dividerColor,
      ),
    );
  }
}
