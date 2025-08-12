import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BalanceHeaderWidget extends StatefulWidget {
  final double currentBalance;
  final double pendingEarnings;
  final bool isPremium;

  const BalanceHeaderWidget({
    Key? key,
    required this.currentBalance,
    required this.pendingEarnings,
    required this.isPremium,
  }) : super(key: key);

  @override
  State<BalanceHeaderWidget> createState() => _BalanceHeaderWidgetState();
}

class _BalanceHeaderWidgetState extends State<BalanceHeaderWidget> {
  bool _isBalanceVisible = true;

  String _formatCurrency(double amount) {
    return '€${amount.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lightTheme.primaryColor,
            AppTheme.lightTheme.primaryColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Verfügbares Guthaben',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName:
                        _isBalanceVisible ? 'visibility_off' : 'visibility',
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            _isBalanceVisible
                ? _formatCurrency(widget.currentBalance)
                : '••••••',
            style: AppTheme.lightTheme.textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),
          if (widget.pendingEarnings > 0) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'schedule',
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Ausstehend: ${_formatCurrency(widget.pendingEarnings)}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (widget.isPremium) ...[
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.warningLight.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'star',
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Premium - 5% Gebühren',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
