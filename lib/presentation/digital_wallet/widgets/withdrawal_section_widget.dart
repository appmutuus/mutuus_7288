import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WithdrawalSectionWidget extends StatefulWidget {
  final double availableBalance;
  final List<Map<String, dynamic>> bankAccounts;
  final VoidCallback? onAddBankAccount;
  final Function(double amount, String accountId)? onWithdraw;

  const WithdrawalSectionWidget({
    Key? key,
    required this.availableBalance,
    required this.bankAccounts,
    this.onAddBankAccount,
    this.onWithdraw,
  }) : super(key: key);

  @override
  State<WithdrawalSectionWidget> createState() =>
      _WithdrawalSectionWidgetState();
}

class _WithdrawalSectionWidgetState extends State<WithdrawalSectionWidget> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedAccountId;
  bool _isProcessing = false;

  String _formatCurrency(double amount) {
    return '€${amount.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void _showWithdrawalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Auszahlung beantragen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Auszahlungsbetrag',
                hintText: '0,00',
                prefixText: '€ ',
              ),
            ),
            SizedBox(height: 2.h),
            if (widget.bankAccounts.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                value: _selectedAccountId,
                decoration: InputDecoration(
                  labelText: 'Bankkonto auswählen',
                ),
                items: widget.bankAccounts.map((account) {
                  return DropdownMenuItem<String>(
                    value: account['id'] as String,
                    child: Text(
                        '${account['bankName']} - ****${account['last4']}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAccountId = value;
                  });
                },
              ),
            ] else ...[
              Text(
                'Bitte fügen Sie zuerst ein Bankkonto hinzu.',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.errorLight,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: widget.bankAccounts.isEmpty || _selectedAccountId == null
                ? null
                : () {
                    final amount = double.tryParse(
                            _amountController.text.replaceAll(',', '.')) ??
                        0.0;
                    if (amount > 0 && amount <= widget.availableBalance) {
                      widget.onWithdraw?.call(amount, _selectedAccountId!);
                      Navigator.pop(context);
                      _amountController.clear();
                    }
                  },
            child: Text('Auszahlen'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Text(
            'Auszahlungen',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Verfügbar für Auszahlung',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    Text(
                      _formatCurrency(widget.availableBalance),
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.successLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: widget.availableBalance > 0
                        ? _showWithdrawalDialog
                        : null,
                    icon: CustomIconWidget(
                      iconName: 'account_balance',
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text('Auszahlung beantragen'),
                  ),
                ),
                if (widget.bankAccounts.isEmpty) ...[
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: widget.onAddBankAccount,
                      icon: CustomIconWidget(
                        iconName: 'add',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 20,
                      ),
                      label: Text('Bankkonto hinzufügen'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (widget.bankAccounts.isNotEmpty) ...[
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Ihre Bankkonten',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          ...widget.bankAccounts
              .map((account) => Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.primaryColor
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: 'account_balance',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 20,
                        ),
                      ),
                      title: Text(account['bankName'] as String),
                      subtitle: Text('****${account['last4']}'),
                      trailing: account['isDefault'] == true
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppTheme.successLight
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Standard',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme.successLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ))
              .toList(),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OutlinedButton.icon(
              onPressed: widget.onAddBankAccount,
              icon: CustomIconWidget(
                iconName: 'add',
                color: AppTheme.lightTheme.primaryColor,
                size: 20,
              ),
              label: Text('Weiteres Konto hinzufügen'),
            ),
          ),
        ],
      ],
    );
  }
}
