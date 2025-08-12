import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GoogleLoginButtonWidget extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final bool isLoading;

  const GoogleLoginButtonWidget({
    Key? key,
    required this.onGoogleLogin,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onGoogleLogin,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          side: BorderSide(
            color: AppTheme.lightTheme.colorScheme.outline,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        ),
        child: isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageWidget(
                    imageUrl:
                        'https://developers.google.com/identity/images/g-logo.png',
                    width: 5.w,
                    height: 5.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 3.w),
                  Flexible(
                    child: Text(
                      'Mit Google anmelden',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
