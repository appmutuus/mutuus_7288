import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SubmitApplicationButton extends StatefulWidget {
  final bool isFormValid;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const SubmitApplicationButton({
    Key? key,
    required this.isFormValid,
    required this.isSubmitting,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SubmitApplicationButton> createState() =>
      _SubmitApplicationButtonState();
}

class _SubmitApplicationButtonState extends State<SubmitApplicationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.isFormValid || widget.isSubmitting) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
      widget.onSubmit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          if (!widget.isFormValid)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.errorLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.errorLight.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info',
                    color: AppTheme.errorLight,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      "Bitte füllen Sie alle erforderlichen Felder aus und akzeptieren Sie die Bedingungen",
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.errorLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: double.infinity,
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: widget.isFormValid && !widget.isSubmitting
                        ? LinearGradient(
                            colors: [
                              AppTheme.lightTheme.colorScheme.primary,
                              AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: !widget.isFormValid || widget.isSubmitting
                        ? AppTheme.lightTheme.colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.3)
                        : null,
                    boxShadow: widget.isFormValid && !widget.isSubmitting
                        ? [
                            BoxShadow(
                              color: AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _handleTap,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.isSubmitting)
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.isFormValid
                                        ? Colors.white
                                        : AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant,
                                  ),
                                ),
                              )
                            else
                              CustomIconWidget(
                                iconName: 'send',
                                color: widget.isFormValid
                                    ? Colors.white
                                    : AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                size: 20,
                              ),
                            SizedBox(width: 3.w),
                            Text(
                              widget.isSubmitting
                                  ? "Wird gesendet..."
                                  : "Bewerbung senden",
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: widget.isFormValid
                                    ? Colors.white
                                    : AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 1.h),
          Text(
            "Ihre Bewerbung wird direkt an den Auftraggeber gesendet",
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
