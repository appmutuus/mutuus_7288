import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LanguageSectionWidget extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSectionWidget({
    super.key,
    this.selectedLanguage = 'Deutsch',
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> languages = [
      {
        'name': 'Deutsch',
        'code': 'de',
        'flag': '🇩🇪',
        'isPrimary': true,
      },
      {
        'name': 'English',
        'code': 'en',
        'flag': '🇺🇸',
        'isPrimary': false,
      },
      {
        'name': 'Français',
        'code': 'fr',
        'flag': '🇫🇷',
        'isPrimary': false,
      },
      {
        'name': 'Español',
        'code': 'es',
        'flag': '🇪🇸',
        'isPrimary': false,
      },
    ];

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
              'Sprache',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),
          ...languages.asMap().entries.map((entry) {
            final index = entry.key;
            final language = entry.value;
            final isSelected = selectedLanguage == (language['name'] as String);

            return Column(
              children: [
                if (index > 0) _buildDivider(),
                _buildLanguageItem(
                  flag: language['flag'] as String,
                  name: language['name'] as String,
                  code: language['code'] as String,
                  isPrimary: language['isPrimary'] as bool,
                  isSelected: isSelected,
                  onTap: () => onLanguageChanged(language['name'] as String),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLanguageItem({
    required String flag,
    required String name,
    required String code,
    required bool isPrimary,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1)
                    : AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(
                        color: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: Center(
                child: Text(
                  flag,
                  style: TextStyle(fontSize: 5.w),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                      ),
                      if (isPrimary) ...[
                        SizedBox(width: 2.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.5.w, vertical: 0.3.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.tertiary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Primär',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.tertiary,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    code.toUpperCase(),
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'check',
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                    size: 3.w,
                  ),
                ),
              )
            else
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
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
