import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/balance_header_widget.dart';
import './widgets/fee_calculator_widget.dart';
import './widgets/quick_action_widget.dart';
import './widgets/transaction_item_widget.dart';
import './widgets/withdrawal_section_widget.dart';

class DigitalWallet extends StatefulWidget {
  const DigitalWallet({Key? key}) : super(key: key);

  @override
  State<DigitalWallet> createState() => _DigitalWalletState();
}

class _DigitalWalletState extends State<DigitalWallet>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Mock user data
  final bool _isPremium = true;
  final double _currentBalance = 1247.85;
  final double _pendingEarnings = 324.50;

  // Mock transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      "id": 1,
      "jobTitle": "Garten aufräumen und Unkraut entfernen",
      "amount": 85.0,
      "fee": 4.25,
      "type": "job_payment",
      "status": "completed",
      "date": "2025-08-10T14:30:00Z",
      "transactionId": "TXN_2025081001",
      "description":
          "Bezahlung für erfolgreich abgeschlossenen Gartenauftrag in München-Schwabing"
    },
    {
      "id": 2,
      "jobTitle": "Umzugshilfe - Möbel tragen",
      "amount": 120.0,
      "fee": 6.0,
      "type": "job_payment",
      "status": "pending",
      "date": "2025-08-09T16:45:00Z",
      "transactionId": "TXN_2025080902",
      "description":
          "Ausstehende Zahlung für Umzugshilfe, wartet auf Kundenbestätigung"
    },
    {
      "id": 3,
      "jobTitle": "Auszahlung auf Bankkonto",
      "amount": -500.0,
      "fee": 0.0,
      "type": "withdrawal",
      "status": "completed",
      "date": "2025-08-08T10:15:00Z",
      "transactionId": "WTH_2025080801",
      "description": "Auszahlung auf Sparkasse München ****1234"
    },
    {
      "id": 4,
      "jobTitle": "Einkaufen und Liefern",
      "amount": 45.0,
      "fee": 2.25,
      "type": "job_payment",
      "status": "completed",
      "date": "2025-08-07T19:20:00Z",
      "transactionId": "TXN_2025080703",
      "description": "Lebensmitteleinkauf und Lieferung für ältere Dame"
    },
    {
      "id": 5,
      "jobTitle": "Hund ausführen - 3 Stunden",
      "amount": 60.0,
      "fee": 3.0,
      "type": "job_payment",
      "status": "failed",
      "date": "2025-08-06T08:30:00Z",
      "transactionId": "TXN_2025080604",
      "description":
          "Zahlung fehlgeschlagen - Kundenkarte abgelehnt, wird erneut versucht"
    }
  ];

  // Mock bank accounts
  final List<Map<String, dynamic>> _bankAccounts = [
    {
      "id": "acc_001",
      "bankName": "Sparkasse München",
      "last4": "1234",
      "isDefault": true
    },
    {
      "id": "acc_002",
      "bankName": "Deutsche Bank",
      "last4": "5678",
      "isDefault": false
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleWithdrawal() {
    Navigator.pushNamed(context, '/settings-and-account');
  }

  void _handleTransactionHistory() {
    _tabController.animateTo(1);
  }

  void _handleUpgrade() {
    Navigator.pushNamed(context, '/settings-and-account');
  }

  void _handleAddBankAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bankkonto-Verwaltung wird geöffnet...'),
        backgroundColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  void _handleWithdraw(double amount, String accountId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Auszahlung von €${amount.toStringAsFixed(2).replaceAll('.', ',')} wurde beantragt'),
        backgroundColor: AppTheme.successLight,
      ),
    );
  }

  Widget _buildBalanceTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: BalanceHeaderWidget(
              currentBalance: _currentBalance,
              pendingEarnings: _pendingEarnings,
              isPremium: _isPremium,
            ),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Schnellaktionen',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                QuickActionWidget(
                  title: 'Auszahlung',
                  iconName: 'account_balance',
                  color: AppTheme.lightTheme.primaryColor,
                  onTap: _handleWithdrawal,
                ),
                SizedBox(width: 3.w),
                QuickActionWidget(
                  title: 'Verlauf',
                  iconName: 'history',
                  color: AppTheme.successLight,
                  onTap: _handleTransactionHistory,
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          FeeCalculatorWidget(
            isPremium: _isPremium,
            onUpgradePressed: _handleUpgrade,
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaktionsverlauf',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('PDF-Export wird vorbereitet...'),
                      backgroundColor: AppTheme.lightTheme.primaryColor,
                    ),
                  );
                },
                icon: CustomIconWidget(
                  iconName: 'download',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 16,
                ),
                label: Text('Export'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _transactions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'receipt_long',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 48,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Keine Transaktionen vorhanden',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Schließen Sie Ihren ersten Auftrag ab,\num Ihre Einnahmen hier zu sehen',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/home-dashboard'),
                        child: Text('Aufträge finden'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionItemWidget(
                      transaction: _transactions[index],
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Transaktionsdetails angezeigt'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildWithdrawalsTab() {
    return SingleChildScrollView(
      child: WithdrawalSectionWidget(
        availableBalance: _currentBalance,
        bankAccounts: _bankAccounts,
        onAddBankAccount: _handleAddBankAccount,
        onWithdraw: _handleWithdraw,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Wallet'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/settings-and-account'),
            icon: CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'account_balance_wallet',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text('Guthaben'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'receipt_long',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text('Transaktionen'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'account_balance',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text('Auszahlungen'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBalanceTab(),
          _buildTransactionsTab(),
          _buildWithdrawalsTab(),
        ],
      ),
    );
  }
}
