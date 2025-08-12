import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AvailabilitySection extends StatefulWidget {
  final DateTime? selectedStartDate;
  final String selectedTimePreference;
  final Function(DateTime?) onStartDateChanged;
  final Function(String) onTimePreferenceChanged;

  const AvailabilitySection({
    Key? key,
    required this.selectedStartDate,
    required this.selectedTimePreference,
    required this.onStartDateChanged,
    required this.onTimePreferenceChanged,
  }) : super(key: key);

  @override
  State<AvailabilitySection> createState() => _AvailabilitySectionState();
}

class _AvailabilitySectionState extends State<AvailabilitySection> {
  final List<Map<String, String>> timePreferences = [
    {"value": "morning", "label": "Morgens (6:00 - 12:00)"},
    {"value": "afternoon", "label": "Nachmittags (12:00 - 18:00)"},
    {"value": "evening", "label": "Abends (18:00 - 22:00)"},
    {"value": "flexible", "label": "Flexibel"},
  ];

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedStartDate ??
          DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('de', 'DE'),
      builder: (context, child) {
        return Theme(
          data: AppTheme.lightTheme.copyWith(
            colorScheme: AppTheme.lightTheme.colorScheme.copyWith(
              primary: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != widget.selectedStartDate) {
      widget.onStartDateChanged(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Datum auswählen";
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

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
                iconName: 'schedule',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                "Verfügbarkeit",
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                "Erforderlich",
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.errorLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            "Startdatum",
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          GestureDetector(
            onTap: _selectStartDate,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'calendar_today',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 18,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    _formatDate(widget.selectedStartDate),
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: widget.selectedStartDate != null
                          ? AppTheme.lightTheme.colorScheme.onSurface
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  CustomIconWidget(
                    iconName: 'arrow_drop_down',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "Bevorzugte Arbeitszeit",
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Column(
            children: timePreferences.map((preference) {
              final isSelected =
                  widget.selectedTimePreference == preference["value"];
              return GestureDetector(
                onTap: () =>
                    widget.onTimePreferenceChanged(preference["value"]!),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 1.h),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme.lightTheme.colorScheme.outline,
                            width: 2,
                          ),
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          preference["label"]!,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: isSelected
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
