import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class JobCardWidget extends StatelessWidget {
  final Map<String, dynamic> job;
  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final VoidCallback? onSave;
  final VoidCallback? onShare;

  const JobCardWidget({
    Key? key,
    required this.job,
    this.onTap,
    this.onApply,
    this.onSave,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPremiumJob = job["isPremium"] ?? false;
    final bool isKarmaJob = job["paymentType"] == "karma";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isPremiumJob
              ? Border.all(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow
                  .withValues(alpha: 0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with category and premium indicator
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.primaryColor
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: job["categoryIcon"] as String? ?? 'work',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job["category"] as String? ?? "Allgemein",
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (isPremiumJob) ...[
                          SizedBox(height: 0.5.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.3.h),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'PREMIUM',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Payment amount or karma points
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                    decoration: BoxDecoration(
                      color: isKarmaJob
                          ? AppTheme.lightTheme.colorScheme.tertiary
                              .withValues(alpha: 0.1)
                          : AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: isKarmaJob ? 'favorite' : 'euro',
                          color: isKarmaJob
                              ? AppTheme.lightTheme.colorScheme.tertiary
                              : AppTheme.lightTheme.primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          isKarmaJob
                              ? '${job["karmaPoints"]} Karma'
                              : '€${job["price"]}',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: isKarmaJob
                                ? AppTheme.lightTheme.colorScheme.tertiary
                                : AppTheme.lightTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Job title and description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job["title"] as String,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    job["description"] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Footer with distance, deadline, and required rank
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Row(
                children: [
                  // Distance
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'location_on',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${job["distance"]} km',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                    ],
                  ),

                  SizedBox(width: 4.w),

                  // Deadline
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        job["deadline"] as String,
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                    ],
                  ),

                  Spacer(),

                  // Required rank
                  if (job["requiredRank"] != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.secondary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            size: 12,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            job["requiredRank"] as String,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
