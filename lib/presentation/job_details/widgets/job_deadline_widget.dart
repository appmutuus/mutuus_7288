import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class JobDeadlineWidget extends StatefulWidget {
  final Map<String, dynamic> jobData;

  const JobDeadlineWidget({
    Key? key,
    required this.jobData,
  }) : super(key: key);

  @override
  State<JobDeadlineWidget> createState() => _JobDeadlineWidgetState();
}

class _JobDeadlineWidgetState extends State<JobDeadlineWidget> {
  late Duration _timeRemaining;
  late bool _isExpired;

  @override
  void initState() {
    super.initState();
    _calculateTimeRemaining();
  }

  void _calculateTimeRemaining() {
    final DateTime deadline =
        DateTime.parse(widget.jobData['deadline'] as String);
    final DateTime now = DateTime.now();
    _timeRemaining = deadline.difference(now);
    _isExpired = _timeRemaining.isNegative;
  }

  String _formatTimeRemaining() {
    if (_isExpired) return 'Abgelaufen';

    final int days = _timeRemaining.inDays;
    final int hours = _timeRemaining.inHours % 24;
    final int minutes = _timeRemaining.inMinutes % 60;

    if (days > 0) {
      return '$days Tag${days > 1 ? 'e' : ''}, $hours Std.';
    } else if (hours > 0) {
      return '$hours Std., $minutes Min.';
    } else {
      return '$minutes Min.';
    }
  }

  Color _getDeadlineColor() {
    if (_isExpired) return AppTheme.errorLight;
    if (_timeRemaining.inHours < 24) return AppTheme.warningLight;
    if (_timeRemaining.inDays < 3) return AppTheme.warningLight;
    return AppTheme.successLight;
  }

  IconData _getDeadlineIcon() {
    if (_isExpired) return Icons.error;
    if (_timeRemaining.inHours < 24) return Icons.warning;
    return Icons.schedule;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime deadline =
        DateTime.parse(widget.jobData['deadline'] as String);
    final Color deadlineColor = _getDeadlineColor();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deadline',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Deadline Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: deadlineColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: deadlineColor.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                // Countdown Timer
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: deadlineColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomIconWidget(
                        iconName: _getDeadlineIcon().codePoint.toString(),
                        color: deadlineColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isExpired ? 'Job abgelaufen' : 'Verbleibende Zeit',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: deadlineColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            _formatTimeRemaining(),
                            style: AppTheme.lightTheme.textTheme.titleLarge
                                ?.copyWith(
                              color: deadlineColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Deadline Date
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'calendar_today',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Deadline: ${_formatDate(deadline)}',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress Bar
                if (!_isExpired) ...[
                  SizedBox(height: 2.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fortschritt',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${_getProgressPercentage()}%',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: deadlineColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      LinearProgressIndicator(
                        value: _getProgressPercentage() / 100,
                        backgroundColor: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(deadlineColor),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
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

    return '${date.day}. ${months[date.month - 1]} ${date.year}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  int _getProgressPercentage() {
    final DateTime created =
        DateTime.parse(widget.jobData['created_at'] as String);
    final DateTime deadline =
        DateTime.parse(widget.jobData['deadline'] as String);
    final DateTime now = DateTime.now();

    final Duration totalDuration = deadline.difference(created);
    final Duration elapsed = now.difference(created);

    if (totalDuration.inMilliseconds == 0) return 100;

    final double progress =
        (elapsed.inMilliseconds / totalDuration.inMilliseconds) * 100;
    return progress.clamp(0, 100).round();
  }
}
