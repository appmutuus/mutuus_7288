import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class JobHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onReportPressed;
  final VoidCallback onSavePressed;
  final bool isSaved;

  const JobHeaderWidget({
    Key? key,
    required this.jobData,
    required this.onBackPressed,
    required this.onSharePressed,
    required this.onReportPressed,
    required this.onSavePressed,
    required this.isSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight:
          jobData['images'] != null && (jobData['images'] as List).isNotEmpty
              ? 30.h
              : 0,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      leading: Container(
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: onBackPressed,
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: PopupMenuButton<String>(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
            onSelected: (value) {
              switch (value) {
                case 'share':
                  onSharePressed();
                  break;
                case 'report':
                  onReportPressed();
                  break;
                case 'save':
                  onSavePressed();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'share',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Teilen',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'save',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: isSaved ? 'bookmark' : 'bookmark_border',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      isSaved ? 'Gespeichert' : 'Speichern',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'flag',
                      color: AppTheme.errorLight,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Melden',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.errorLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      flexibleSpace: jobData['images'] != null &&
              (jobData['images'] as List).isNotEmpty
          ? FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.3),
                    ],
                  ),
                ),
                child: PageView.builder(
                  itemCount: (jobData['images'] as List).length,
                  itemBuilder: (context, index) {
                    return CustomImageWidget(
                      imageUrl: (jobData['images'] as List)[index] as String,
                      width: double.infinity,
                      height: 30.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
