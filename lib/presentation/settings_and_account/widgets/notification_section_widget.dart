import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NotificationSectionWidget extends StatefulWidget {
  final bool jobApplicationsEnabled;
  final bool acceptancesEnabled;
  final bool messagesEnabled;
  final bool deadlinesEnabled;
  final bool marketingEnabled;
  final Function(String, bool) onNotificationChanged;

  const NotificationSectionWidget({
    super.key,
    this.jobApplicationsEnabled = true,
    this.acceptancesEnabled = true,
    this.messagesEnabled = true,
    this.deadlinesEnabled = true,
    this.marketingEnabled = false,
    required this.onNotificationChanged,
  });

  @override
  State<NotificationSectionWidget> createState() =>
      _NotificationSectionWidgetState();
}

class _NotificationSectionWidgetState extends State<NotificationSectionWidget> {
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
              'Benachrichtigungen',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
          _buildNotificationToggle(
            icon: 'work',
            title: 'Job-Bewerbungen',
            subtitle: 'Neue Bewerbungen für Ihre Jobs',
            value: widget.jobApplicationsEnabled,
            key: 'jobApplications',
          ),
          _buildDivider(),
          _buildNotificationToggle(
            icon: 'check_circle',
            title: 'Annahmen',
            subtitle: 'Wenn Ihre Bewerbung angenommen wird',
            value: widget.acceptancesEnabled,
            key: 'acceptances',
          ),
          _buildDivider(),
          _buildNotificationToggle(
            icon: 'message',
            title: 'Nachrichten',
            subtitle: 'Neue Chat-Nachrichten',
            value: widget.messagesEnabled,
            key: 'messages',
          ),
          _buildDivider(),
          _buildNotificationToggle(
            icon: 'schedule',
            title: 'Fristen',
            subtitle: 'Erinnerungen an Job-Deadlines',
            value: widget.deadlinesEnabled,
            key: 'deadlines',
          ),
          _buildDivider(),
          _buildNotificationToggle(
            icon: 'campaign',
            title: 'Marketing',
            subtitle: 'Neuigkeiten und Angebote',
            value: widget.marketingEnabled,
            key: 'marketing',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle({
    required String icon,
    required String title,
    required String subtitle,
    required bool value,
    required String key,
  }) {
    return Padding(
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
          Switch(
            value: value,
            onChanged: (newValue) =>
                widget.onNotificationChanged(key, newValue),
            activeColor: AppTheme.lightTheme.colorScheme.primary,
            inactiveThumbColor:
                AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            inactiveTrackColor:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ],
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
