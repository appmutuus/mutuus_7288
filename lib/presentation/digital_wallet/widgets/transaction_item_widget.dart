import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TransactionItemWidget extends StatefulWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback? onTap;

  const TransactionItemWidget({
    Key? key,
    required this.transaction,
    this.onTap,
  }) : super(key: key);

  @override
  State<TransactionItemWidget> createState() => _TransactionItemWidgetState();
}

class _TransactionItemWidgetState extends State<TransactionItemWidget> {
  bool _isExpanded = false;

  String _formatCurrency(double amount) {
    return '€${amount.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppTheme.successLight;
      case 'pending':
        return AppTheme.warningLight;
      case 'failed':
        return AppTheme.errorLight;
      default:
        return AppTheme.lightTheme.colorScheme.secondary;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Abgeschlossen';
      case 'pending':
        return 'Ausstehend';
      case 'failed':
        return 'Fehlgeschlagen';
      default:
        return status;
    }
  }

  IconData _getTransactionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'job_payment':
        return Icons.work;
      case 'withdrawal':
        return Icons.account_balance;
      case 'fee':
        return Icons.receipt;
      case 'refund':
        return Icons.refresh;
      default:
        return Icons.payment;
    }
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final amount = (transaction['amount'] as num).toDouble();
    final fee = (transaction['fee'] as num?)?.toDouble() ?? 0.0;
    final netAmount = amount - fee;
    final date = DateTime.parse(transaction['date'] as String);
    final status = transaction['status'] as String;
    final type = transaction['type'] as String;
    final jobTitle = transaction['jobTitle'] as String?;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
          widget.onTap?.call();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: _getTransactionIcon(type).codePoint.toString(),
                      color: _getStatusColor(status),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobTitle ?? 'Transaktion',
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          _formatDate(date),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatCurrency(netAmount),
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: amount > 0
                              ? AppTheme.successLight
                              : AppTheme.errorLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusText(status),
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: _getStatusColor(status),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: _isExpanded ? 'expand_less' : 'expand_more',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaktionsdetails',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      _buildDetailRow('Bruttobetrag', _formatCurrency(amount)),
                      if (fee > 0)
                        _buildDetailRow('Gebühr', '-${_formatCurrency(fee)}'),
                      _buildDetailRow(
                          'Nettobetrag', _formatCurrency(netAmount)),
                      if (transaction['transactionId'] != null) ...[
                        SizedBox(height: 1.h),
                        _buildDetailRow('Transaktions-ID',
                            transaction['transactionId'] as String),
                      ],
                      if (transaction['description'] != null) ...[
                        SizedBox(height: 1.h),
                        Text(
                          'Beschreibung',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          transaction['description'] as String,
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
