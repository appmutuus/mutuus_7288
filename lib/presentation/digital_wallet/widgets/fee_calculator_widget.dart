import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FeeCalculatorWidget extends StatefulWidget {
  final bool isPremium;
  final VoidCallback? onUpgradePressed;

  const FeeCalculatorWidget({
    Key? key,
    required this.isPremium,
    this.onUpgradePressed,
  }) : super(key: key);

  @override
  State<FeeCalculatorWidget> createState() => _FeeCalculatorWidgetState();
}

class _FeeCalculatorWidgetState extends State<FeeCalculatorWidget> {
  final TextEditingController _amountController = TextEditingController();
  double _calculatedFee = 0.0;
  double _netAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_calculateFee);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _calculateFee() {
    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0.0;
    final feeRate = widget.isPremium ? 0.05 : 0.098;

    setState(() {
      _calculatedFee = amount * feeRate;
      _netAmount = amount - _calculatedFee;
    });
  }

  String _formatCurrency(double amount) {
    return '€${amount.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4.w),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'calculate',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Gebührenrechner',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Auftragswert eingeben',
                hintText: '0,00',
                prefixText: '€ ',
                suffixIcon: _amountController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _amountController.clear();
                        },
                        icon: CustomIconWidget(
                          iconName: 'clear',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gebührensatz:',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.isPremium ? '5%' : '9,8%',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: widget.isPremium
                                  ? AppTheme.successLight
                                  : AppTheme.warningLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (widget.isPremium) ...[
                            SizedBox(width: 2.w),
                            CustomIconWidget(
                              iconName: 'star',
                              color: AppTheme.warningLight,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Plattformgebühr:',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                      Text(
                        _formatCurrency(_calculatedFee),
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.errorLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Divider(color: AppTheme.lightTheme.colorScheme.outline),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sie erhalten:',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _formatCurrency(_netAmount),
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.successLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!widget.isPremium) ...[
              SizedBox(height: 3.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.warningLight.withValues(alpha: 0.1),
                      AppTheme.warningLight.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.warningLight.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.warningLight,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Premium Upgrade',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.warningLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Sparen Sie 4,8% Gebühren mit Premium! Nur €14,99/Monat',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onUpgradePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.warningLight,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Jetzt upgraden'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
