import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PersonalMessageSection extends StatefulWidget {
  final TextEditingController messageController;
  final Function(String) onMessageChanged;

  const PersonalMessageSection({
    Key? key,
    required this.messageController,
    required this.onMessageChanged,
  }) : super(key: key);

  @override
  State<PersonalMessageSection> createState() => _PersonalMessageSectionState();
}

class _PersonalMessageSectionState extends State<PersonalMessageSection> {
  static const int maxCharacters = 500;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'message',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                "Persönliche Nachricht",
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                "Optional",
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: _isExpanded ? 20.h : 12.h,
              maxHeight: _isExpanded ? 30.h : 12.h,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: TextField(
              controller: widget.messageController,
              onChanged: (value) {
                widget.onMessageChanged(value);
                setState(() {});
              },
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText:
                    "Stellen Sie sich vor und erklären Sie, warum Sie der richtige Kandidat für diese Aufgabe sind...",
                hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.6),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(3.w),
                counterText: "",
              ),
              maxLength: maxCharacters,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: _isExpanded ? 'expand_less' : 'expand_more',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        _isExpanded ? "Weniger" : "Erweitern",
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${widget.messageController.text.length}/$maxCharacters",
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color:
                      widget.messageController.text.length > maxCharacters * 0.9
                          ? AppTheme.errorLight
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
