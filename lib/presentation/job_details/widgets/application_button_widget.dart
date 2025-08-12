import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ApplicationButtonWidget extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final Map<String, dynamic> userData;
  final VoidCallback onApplyPressed;
  final VoidCallback onUpgradePressed;

  const ApplicationButtonWidget({
    Key? key,
    required this.jobData,
    required this.userData,
    required this.onApplyPressed,
    required this.onUpgradePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isExpired = _isJobExpired();
    final bool isFilled = jobData['status'] == 'filled';
    final bool hasApplied = jobData['has_applied'] ?? false;
    final bool isPremiumJob = jobData['is_premium'] ?? false;
    final bool isUserPremium = userData['is_premium'] ?? false;
    final bool meetsRankRequirement = _meetsRankRequirement();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status Messages
            if (!meetsRankRequirement) ...[
              _buildWarningMessage(
                'Mindestrang erforderlich: ${jobData['minimum_rank']}',
                Icons.military_tech,
              ),
              SizedBox(height: 2.h),
            ] else if (isPremiumJob && !isUserPremium) ...[
              _buildWarningMessage(
                'Premium-Mitgliedschaft erforderlich für diesen Job',
                Icons.star,
              ),
              SizedBox(height: 2.h),
            ] else if (hasApplied) ...[
              _buildSuccessMessage(
                'Du hast dich bereits für diesen Job beworben',
                Icons.check_circle,
              ),
              SizedBox(height: 2.h),
            ] else if (isExpired) ...[
              _buildErrorMessage(
                'Dieser Job ist abgelaufen',
                Icons.error,
              ),
              SizedBox(height: 2.h),
            ] else if (isFilled) ...[
              _buildErrorMessage(
                'Dieser Job wurde bereits vergeben',
                Icons.person_add_disabled,
              ),
              SizedBox(height: 2.h),
            ],

            // Action Buttons
            Row(
              children: [
                // Main Action Button
                Expanded(
                  flex: 3,
                  child: _buildMainButton(
                    isExpired: isExpired,
                    isFilled: isFilled,
                    hasApplied: hasApplied,
                    isPremiumJob: isPremiumJob,
                    isUserPremium: isUserPremium,
                    meetsRankRequirement: meetsRankRequirement,
                  ),
                ),

                // Upgrade Button (if needed)
                if (isPremiumJob && !isUserPremium) ...[
                  SizedBox(width: 3.w),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton.icon(
                      onPressed: onUpgradePressed,
                      icon: CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.warningLight,
                        size: 18,
                      ),
                      label: Text(
                        'Upgrade',
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          color: AppTheme.warningLight,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppTheme.warningLight),
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Additional Info
            if (!isExpired && !isFilled && !hasApplied) ...[
              SizedBox(height: 2.h),
              _buildApplicationInfo(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton({
    required bool isExpired,
    required bool isFilled,
    required bool hasApplied,
    required bool isPremiumJob,
    required bool isUserPremium,
    required bool meetsRankRequirement,
  }) {
    String buttonText = 'Jetzt bewerben';
    bool isEnabled = true;
    Color? backgroundColor;
    Color? textColor;

    if (hasApplied) {
      buttonText = 'Bereits beworben';
      isEnabled = false;
      backgroundColor = AppTheme.successLight.withValues(alpha: 0.1);
      textColor = AppTheme.successLight;
    } else if (isExpired) {
      buttonText = 'Abgelaufen';
      isEnabled = false;
      backgroundColor = AppTheme.errorLight.withValues(alpha: 0.1);
      textColor = AppTheme.errorLight;
    } else if (isFilled) {
      buttonText = 'Vergeben';
      isEnabled = false;
      backgroundColor = AppTheme.errorLight.withValues(alpha: 0.1);
      textColor = AppTheme.errorLight;
    } else if (!meetsRankRequirement) {
      buttonText = 'Rang zu niedrig';
      isEnabled = false;
      backgroundColor = AppTheme.warningLight.withValues(alpha: 0.1);
      textColor = AppTheme.warningLight;
    } else if (isPremiumJob && !isUserPremium) {
      buttonText = 'Premium erforderlich';
      isEnabled = false;
      backgroundColor = AppTheme.warningLight.withValues(alpha: 0.1);
      textColor = AppTheme.warningLight;
    }

    return ElevatedButton(
      onPressed: isEnabled ? onApplyPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        buttonText,
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          color: textColor ?? AppTheme.lightTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildWarningMessage(String message, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.warningLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.warningLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon.codePoint.toString(),
            color: AppTheme.warningLight,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              message,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.warningLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage(String message, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.successLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.successLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon.codePoint.toString(),
            color: AppTheme.successLight,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              message,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.successLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String message, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.errorLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.errorLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon.codePoint.toString(),
            color: AppTheme.errorLight,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              message,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.errorLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationInfo() {
    final bool isKarmaJob = jobData['payment_type'] == 'karma';
    final String feeText = isKarmaJob
        ? 'Keine Gebühren für Karma-Jobs'
        : userData['is_premium'] == true
            ? 'Premium-Gebühr: 5%'
            : 'Standard-Gebühr: 9,8%';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'info',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  feeText,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          if (!isKarmaJob) ...[
            SizedBox(height: 1.h),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'account_balance_wallet',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    'Zahlung erfolgt nach Jobabschluss',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  bool _isJobExpired() {
    final DateTime deadline = DateTime.parse(jobData['deadline'] as String);
    return DateTime.now().isAfter(deadline);
  }

  bool _meetsRankRequirement() {
    final int? minimumRank = jobData['minimum_rank'];
    if (minimumRank == null) return true;

    final int userRank = userData['rank'] ?? 1;
    return userRank >= minimumRank;
  }
}
