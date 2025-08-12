import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ApplicationTermsSection extends StatelessWidget {
  final bool isTermsAccepted;
  final Function(bool) onTermsChanged;

  const ApplicationTermsSection({
    Key? key,
    required this.isTermsAccepted,
    required this.onTermsChanged,
  }) : super(key: key);

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
                iconName: 'gavel',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                "Bewerbungsbedingungen",
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTermItem(
                  icon: 'check_circle',
                  text: "Ich bestätige, dass alle Angaben wahrheitsgemäß sind",
                ),
                SizedBox(height: 1.h),
                _buildTermItem(
                  icon: 'schedule',
                  text:
                      "Ich verpflichte mich, die vereinbarten Fristen einzuhalten",
                ),
                SizedBox(height: 1.h),
                _buildTermItem(
                  icon: 'star',
                  text:
                      "Ich akzeptiere das Bewertungssystem nach Auftragsabschluss",
                ),
                SizedBox(height: 1.h),
                _buildTermItem(
                  icon: 'payment',
                  text:
                      "Ich verstehe die Zahlungsbedingungen und Gebührenstruktur",
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: () => onTermsChanged(!isTermsAccepted),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isTermsAccepted
                    ? AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isTermsAccepted
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                  width: isTermsAccepted ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isTermsAccepted
                          ? AppTheme.lightTheme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isTermsAccepted
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: isTermsAccepted
                        ? CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                        children: [
                          const TextSpan(
                            text: "Ich akzeptiere die ",
                          ),
                          TextSpan(
                            text: "Allgemeinen Geschäftsbedingungen",
                            style: TextStyle(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(
                            text: " und die ",
                          ),
                          TextSpan(
                            text: "Datenschutzrichtlinie",
                            style: TextStyle(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(
                            text: " von Mutuus.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isTermsAccepted)
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                "Bitte akzeptieren Sie die Bedingungen, um fortzufahren",
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.errorLight,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTermItem({required String icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.successLight,
          size: 16,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            text,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
