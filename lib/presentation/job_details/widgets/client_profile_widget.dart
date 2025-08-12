import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ClientProfileWidget extends StatefulWidget {
  final Map<String, dynamic> clientData;
  final VoidCallback onProfileTap;

  const ClientProfileWidget({
    Key? key,
    required this.clientData,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  State<ClientProfileWidget> createState() => _ClientProfileWidgetState();
}

class _ClientProfileWidgetState extends State<ClientProfileWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double rating = widget.clientData['rating']?.toDouble() ?? 0.0;
    final int completedJobs = widget.clientData['completed_jobs'] ?? 0;
    final bool isVerified = widget.clientData['is_verified'] ?? false;
    final bool isKycVerified = widget.clientData['is_kyc_verified'] ?? false;
    final List<String> badges = widget.clientData['badges'] != null
        ? (widget.clientData['badges'] as List).cast<String>()
        : [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Auftraggeber',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Client Profile Card
          GestureDetector(
            onTap: widget.onProfileTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  // Basic Profile Info
                  Row(
                    children: [
                      // Avatar
                      Container(
                        width: 15.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: widget.clientData['avatar'] != null
                              ? CustomImageWidget(
                                  imageUrl:
                                      widget.clientData['avatar'] as String,
                                  width: 15.w,
                                  height: 15.w,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: AppTheme.lightTheme.colorScheme.primary
                                      .withValues(alpha: 0.1),
                                  child: Center(
                                    child: Text(
                                      (widget.clientData['name'] as String)
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: AppTheme
                                          .lightTheme.textTheme.titleLarge
                                          ?.copyWith(
                                        color: AppTheme
                                            .lightTheme.colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 3.w),

                      // Name and Verification
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.clientData['name'] as String,
                                    style: AppTheme
                                        .lightTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isVerified) ...[
                                  SizedBox(width: 1.w),
                                  CustomIconWidget(
                                    iconName: 'verified',
                                    color: AppTheme.successLight,
                                    size: 16,
                                  ),
                                ],
                                if (isKycVerified) ...[
                                  SizedBox(width: 1.w),
                                  CustomIconWidget(
                                    iconName: 'security',
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    size: 16,
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 0.5.h),

                            // Rating and Jobs
                            Row(
                              children: [
                                // Rating
                                Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'star',
                                      color: AppTheme.warningLight,
                                      size: 16,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      rating.toStringAsFixed(1),
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 3.w),

                                // Completed Jobs
                                Text(
                                  '$completedJobs Job${completedJobs != 1 ? 's' : ''} abgeschlossen',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Expand Button
                      IconButton(
                        onPressed: () =>
                            setState(() => _isExpanded = !_isExpanded),
                        icon: CustomIconWidget(
                          iconName: _isExpanded ? 'expand_less' : 'expand_more',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 24,
                        ),
                      ),
                    ],
                  ),

                  // Expanded Content
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        SizedBox(height: 2.h),
                        Divider(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.2),
                        ),
                        SizedBox(height: 2.h),

                        // Badges
                        if (badges.isNotEmpty) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Auszeichnungen',
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Wrap(
                            spacing: 2.w,
                            runSpacing: 1.h,
                            children: badges
                                .map((badge) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 0.5.h),
                                      decoration: BoxDecoration(
                                        color: AppTheme
                                            .lightTheme.colorScheme.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        badge,
                                        style: AppTheme
                                            .lightTheme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: AppTheme
                                              .lightTheme.colorScheme.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          SizedBox(height: 2.h),
                        ],

                        // Member Since
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'calendar_today',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Mitglied seit ${_formatMemberSince(widget.clientData['member_since'] as String)}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),

                        // Response Time
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'schedule',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Antwortet normalerweise innerhalb von ${widget.clientData['response_time'] ?? '24'} Stunden',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    crossFadeState: _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatMemberSince(String memberSince) {
    final DateTime date = DateTime.parse(memberSince);
    final List<String> months = [
      'Jan',
      'Feb',
      'Mär',
      'Apr',
      'Mai',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Okt',
      'Nov',
      'Dez'
    ];

    return '${months[date.month - 1]} ${date.year}';
  }
}
