import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AccountSectionWidget extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onPasswordTap;
  final VoidCallback? onGoogleAccountTap;
  final VoidCallback? onKycTap;
  final bool isGoogleLinked;
  final bool isKycVerified;

  const AccountSectionWidget({
    super.key,
    this.onProfileTap,
    this.onPasswordTap,
    this.onGoogleAccountTap,
    this.onKycTap,
    this.isGoogleLinked = false,
    this.isKycVerified = false,
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
              'Konto',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
          _buildAccountItem(
            context,
            icon: 'person',
            title: 'Profil bearbeiten',
            subtitle: 'Persönliche Informationen verwalten',
            onTap: onProfileTap,
          ),
          _buildDivider(),
          _buildAccountItem(
            context,
            icon: 'lock',
            title: 'Passwort ändern',
            subtitle: 'Sicherheit Ihres Kontos verwalten',
            onTap: onPasswordTap,
          ),
          _buildDivider(),
          _buildAccountItem(
            context,
            icon: 'account_circle',
            title: 'Google-Konto',
            subtitle: isGoogleLinked ? 'Verknüpft' : 'Nicht verknüpft',
            onTap: onGoogleAccountTap,
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: isGoogleLinked
                    ? AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.1)
                    : AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isGoogleLinked ? 'Aktiv' : 'Inaktiv',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: isGoogleLinked
                      ? AppTheme.lightTheme.colorScheme.tertiary
                      : AppTheme.lightTheme.colorScheme.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _buildDivider(),
          _buildAccountItem(
            context,
            icon: 'verified_user',
            title: 'KYC-Verifizierung',
            subtitle: isKycVerified ? 'Verifiziert' : 'Ausstehend',
            onTap: onKycTap,
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: isKycVerified
                    ? AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.1)
                    : AppTheme.warningLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isKycVerified ? 'Verifiziert' : 'Ausstehend',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: isKycVerified
                      ? AppTheme.lightTheme.colorScheme.tertiary
                      : AppTheme.warningLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
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
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: icon,
                  color: AppTheme.lightTheme.colorScheme.primary,
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
                      color: AppTheme.lightTheme.colorScheme.onSurface,
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
