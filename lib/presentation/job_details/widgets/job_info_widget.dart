import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class JobInfoWidget extends StatelessWidget {
  final Map<String, dynamic> jobData;

  const JobInfoWidget({
    Key? key,
    required this.jobData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isKarmaJob = jobData['payment_type'] == 'karma';
    final bool isUrgent = jobData['is_urgent'] ?? false;
    final bool isPremium = jobData['is_premium'] ?? false;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Title
          Text(
            jobData['title'] as String,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Payment and Tags Row
          Row(
            children: [
              // Payment Amount or Karma
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isKarmaJob
                      ? AppTheme.successLight.withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: isKarmaJob ? 'favorite' : 'euro',
                      color: isKarmaJob
                          ? AppTheme.successLight
                          : AppTheme.lightTheme.colorScheme.primary,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      isKarmaJob
                          ? '${jobData['karma_points']} Karma'
                          : '€${jobData['payment_amount']}',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: isKarmaJob
                            ? AppTheme.successLight
                            : AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),

              // Urgent Tag
              if (isUrgent) ...[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.warningLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: AppTheme.warningLight,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Dringend',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.warningLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
              ],

              // Premium Tag
              if (isPremium) ...[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.warningLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.warningLight,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Premium',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.warningLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 2.h),

          // Category
          Row(
            children: [
              CustomIconWidget(
                iconName: 'category',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                jobData['category'] as String,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // Minimum Rank Requirement
          if (jobData['minimum_rank'] != null) ...[
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'military_tech',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Mindestrang: ${jobData['minimum_rank']}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
          ],

          // Posted Time
          Row(
            children: [
              CustomIconWidget(
                iconName: 'access_time',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                'Veröffentlicht ${_getTimeAgo(jobData['created_at'] as String)}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(String createdAt) {
    final DateTime created = DateTime.parse(createdAt);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(created);

    if (difference.inDays > 0) {
      return 'vor ${difference.inDays} Tag${difference.inDays > 1 ? 'en' : ''}';
    } else if (difference.inHours > 0) {
      return 'vor ${difference.inHours} Stunde${difference.inHours > 1 ? 'n' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'vor ${difference.inMinutes} Minute${difference.inMinutes > 1 ? 'n' : ''}';
    } else {
      return 'gerade eben';
    }
  }
}
