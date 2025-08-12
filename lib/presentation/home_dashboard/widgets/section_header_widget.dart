import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final bool isSticky;

  const SectionHeaderWidget({
    Key? key,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.isSticky = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isSticky
            ? AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.95)
            : AppTheme.lightTheme.colorScheme.surface,
        border: isSticky
            ? Border(
                bottom: BorderSide(
                  color:
                      AppTheme.lightTheme.dividerColor.withValues(alpha: 0.5),
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (actionText != null && onActionTap != null)
            GestureDetector(
              onTap: onActionTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      actionText!,
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    CustomIconWidget(
                      iconName: 'arrow_forward',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
