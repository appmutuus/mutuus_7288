import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class JobDescriptionWidget extends StatefulWidget {
  final Map<String, dynamic> jobData;

  const JobDescriptionWidget({
    Key? key,
    required this.jobData,
  }) : super(key: key);

  @override
  State<JobDescriptionWidget> createState() => _JobDescriptionWidgetState();
}

class _JobDescriptionWidgetState extends State<JobDescriptionWidget> {
  bool _isExpanded = false;
  final int _maxLines = 4;

  @override
  Widget build(BuildContext context) {
    final String description = widget.jobData['description'] as String;
    final List<String> requirements = widget.jobData['requirements'] != null
        ? (widget.jobData['requirements'] as List).cast<String>()
        : [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description Section
          Text(
            'Beschreibung',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          AnimatedCrossFade(
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyLarge,
                  maxLines: _maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                if (description.split('\n').length > _maxLines ||
                    description.length > 200) ...[
                  SizedBox(height: 1.h),
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = true),
                    child: Text(
                      'Mehr anzeigen',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyLarge,
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () => setState(() => _isExpanded = false),
                  child: Text(
                    'Weniger anzeigen',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),

          // Requirements Section
          if (requirements.isNotEmpty) ...[
            SizedBox(height: 3.h),
            Text(
              'Anforderungen',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            ...requirements
                .map((requirement) => Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h, right: 2.w),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              requirement,
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ],
      ),
    );
  }
}
