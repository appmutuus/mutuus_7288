import 'package:flutter/material.dart' hide ThemeMode;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/account_section_widget.dart';
import './widgets/appearance_section_widget.dart';
import './widgets/footer_section_widget.dart';
import './widgets/language_section_widget.dart';
import './widgets/notification_section_widget.dart';
import './widgets/privacy_section_widget.dart';
import './widgets/subscription_section_widget.dart';
import './widgets/support_section_widget.dart';

class SettingsAndAccount extends StatefulWidget {
  const SettingsAndAccount({super.key});

  @override
  State<SettingsAndAccount> createState() => _SettingsAndAccountState();
}

class _SettingsAndAccountState extends State<SettingsAndAccount>
    with TickerProviderStateMixin {
  // User data mock
  final Map<String, dynamic> userData = {
    "id": 1,
    "name": "Max Mustermann",
    "email": "max.mustermann@email.com",
    "isGoogleLinked": true,
    "isKycVerified": true,
    "isPremium": true,
    "subscriptionEndDate": "15.09.2025",
    "profileVisible": true,
    "leaderboardVisible": true,
    "selectedTheme": "system",
    "glowEffectsEnabled": true,
    "selectedLanguage": "Deutsch",
    "notifications": {
      "jobApplications": true,
      "acceptances": true,
      "messages": true,
      "deadlines": true,
      "marketing": false,
    },
  };

  late AnimationController _logoutAnimationController;
  late Animation<double> _blurAnimation;
  late Animation<double> _scaleAnimation;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _logoutAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _blurAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _logoutAnimationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoutAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));
  }

  @override
  void dispose() {
    _logoutAnimationController.dispose();
    super.dispose();
  }

  void _handleThemeChange(ThemeMode theme) {
    setState(() {
      userData['selectedTheme'] = theme.name;
    });
    _showFeedback('Design-Modus auf ${_getThemeName(theme)} geändert');
  }

  String _getThemeName(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        return 'Hell';
      case ThemeMode.dark:
        return 'Dunkel';
      case ThemeMode.system:
        return 'System';
    }
  }

  ThemeMode _getThemeMode(String themeName) {
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  void _handleGlowEffectsChange(bool enabled) {
    setState(() {
      userData['glowEffectsEnabled'] = enabled;
    });
    _showFeedback(
        enabled ? 'Leuchteffekte aktiviert' : 'Leuchteffekte deaktiviert');
  }

  void _handleNotificationChange(String type, bool enabled) {
    setState(() {
      (userData['notifications'] as Map<String, dynamic>)[type] = enabled;
    });
    _showFeedback('Benachrichtigungseinstellungen aktualisiert');
  }

  void _handleLanguageChange(String language) {
    setState(() {
      userData['selectedLanguage'] = language;
    });
    _showFeedback('Sprache auf $language geändert');
  }

  void _showFeedback(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      textColor: AppTheme.lightTheme.colorScheme.onPrimary,
      fontSize: 14.sp,
    );
  }

  void _showConfirmationDialog({
    required String title,
    required String content,
    required String confirmText,
    required VoidCallback onConfirm,
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDestructive
                  ? AppTheme.lightTheme.colorScheme.error
                  : AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          content: Text(
            content,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Abbrechen',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive
                    ? AppTheme.lightTheme.colorScheme.error
                    : AppTheme.lightTheme.colorScheme.primary,
                foregroundColor: isDestructive
                    ? AppTheme.lightTheme.colorScheme.onError
                    : AppTheme.lightTheme.colorScheme.onPrimary,
              ),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    _showConfirmationDialog(
      title: 'Abmelden',
      content:
          'Möchten Sie sich wirklich abmelden? Sie müssen sich erneut anmelden, um auf Ihr Konto zuzugreifen.',
      confirmText: 'Abmelden',
      isDestructive: true,
      onConfirm: _performLogout,
    );
  }

  Future<void> _performLogout() async {
    setState(() {
      _isLoggingOut = true;
    });

    await _logoutAnimationController.forward();

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login-screen',
        (route) => false,
      );
    }
  }

  void _handleDataExport() {
    _showConfirmationDialog(
      title: 'Daten exportieren',
      content:
          'Ihre persönlichen Daten werden als PDF-Datei exportiert und heruntergeladen. Dies kann einige Minuten dauern.',
      confirmText: 'Exportieren',
      onConfirm: () {
        _showFeedback(
            'Datenexport gestartet. Sie erhalten eine Benachrichtigung, wenn der Download bereit ist.');
      },
    );
  }

  void _handleAccountDeletion() {
    _showConfirmationDialog(
      title: 'Konto löschen',
      content:
          'WARNUNG: Diese Aktion kann nicht rückgängig gemacht werden. Alle Ihre Daten, Jobs, Bewertungen und Ihr Guthaben werden permanent gelöscht.',
      confirmText: 'Permanent löschen',
      isDestructive: true,
      onConfirm: () {
        _showFeedback(
            'Kontolöschung eingeleitet. Sie erhalten eine E-Mail zur Bestätigung.');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor:
                    AppTheme.lightTheme.appBarTheme.backgroundColor,
                foregroundColor:
                    AppTheme.lightTheme.appBarTheme.foregroundColor,
                elevation: 0,
                floating: true,
                snap: true,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 6.w,
                  ),
                ),
                title: Text(
                  'Einstellungen',
                  style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 2.h),

                    // User Profile Header
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            AppTheme.lightTheme.colorScheme.tertiary
                                .withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 16.w,
                            height: 16.w,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                (userData['name'] as String)
                                    .split(' ')
                                    .map((name) => name[0])
                                    .join(''),
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['name'] as String,
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme
                                        .lightTheme.colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  userData['email'] as String,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    if (userData['isPremium'] as bool) ...[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                          color: AppTheme.warningLight
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomIconWidget(
                                              iconName: 'star',
                                              color: AppTheme.warningLight,
                                              size: 3.w,
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              'Premium',
                                              style: AppTheme.lightTheme
                                                  .textTheme.labelSmall
                                                  ?.copyWith(
                                                color: AppTheme.warningLight,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                    ],
                                    if (userData['isKycVerified'] as bool)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                          color: AppTheme
                                              .lightTheme.colorScheme.tertiary
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomIconWidget(
                                              iconName: 'verified',
                                              color: AppTheme.lightTheme
                                                  .colorScheme.tertiary,
                                              size: 3.w,
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              'Verifiziert',
                                              style: AppTheme.lightTheme
                                                  .textTheme.labelSmall
                                                  ?.copyWith(
                                                color: AppTheme.lightTheme
                                                    .colorScheme.tertiary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Account Section
                    AccountSectionWidget(
                      isGoogleLinked: userData['isGoogleLinked'] as bool,
                      isKycVerified: userData['isKycVerified'] as bool,
                      onProfileTap: () =>
                          _showFeedback('Profil bearbeiten geöffnet'),
                      onPasswordTap: () =>
                          _showFeedback('Passwort ändern geöffnet'),
                      onGoogleAccountTap: () =>
                          _showFeedback('Google-Konto Einstellungen geöffnet'),
                      onKycTap: () =>
                          _showFeedback('KYC-Verifizierung geöffnet'),
                    ),

                    // Appearance Section
                    AppearanceSectionWidget(
                      selectedTheme:
                          _getThemeMode(userData['selectedTheme'] as String),
                      glowEffectsEnabled:
                          userData['glowEffectsEnabled'] as bool,
                      onThemeChanged: _handleThemeChange,
                      onGlowEffectsChanged: _handleGlowEffectsChange,
                    ),

                    // Notification Section
                    NotificationSectionWidget(
                      jobApplicationsEnabled: (userData['notifications']
                          as Map<String, dynamic>)['jobApplications'] as bool,
                      acceptancesEnabled: (userData['notifications']
                          as Map<String, dynamic>)['acceptances'] as bool,
                      messagesEnabled: (userData['notifications']
                          as Map<String, dynamic>)['messages'] as bool,
                      deadlinesEnabled: (userData['notifications']
                          as Map<String, dynamic>)['deadlines'] as bool,
                      marketingEnabled: (userData['notifications']
                          as Map<String, dynamic>)['marketing'] as bool,
                      onNotificationChanged: _handleNotificationChange,
                    ),

                    // Privacy Section
                    PrivacySectionWidget(
                      profileVisible: userData['profileVisible'] as bool,
                      leaderboardVisible:
                          userData['leaderboardVisible'] as bool,
                      onDataExportTap: _handleDataExport,
                      onAccountDeletionTap: _handleAccountDeletion,
                      onVisibilityControlsTap: () =>
                          _showFeedback('Sichtbarkeitseinstellungen geöffnet'),
                    ),

                    // Support Section
                    SupportSectionWidget(
                      onFaqTap: () => _showFeedback('FAQ geöffnet'),
                      onSupportTicketTap: () =>
                          _showFeedback('Support-Ticket erstellen geöffnet'),
                      onFeedbackTap: () =>
                          _showFeedback('Feedback-Formular geöffnet'),
                    ),

                    // Subscription Section
                    SubscriptionSectionWidget(
                      isPremium: userData['isPremium'] as bool,
                      subscriptionEndDate:
                          userData['subscriptionEndDate'] as String?,
                      onManageSubscriptionTap: () =>
                          _showFeedback('Abonnement verwalten geöffnet'),
                      onUpgradeTap: () =>
                          _showFeedback('Premium-Upgrade geöffnet'),
                    ),

                    // Language Section
                    LanguageSectionWidget(
                      selectedLanguage: userData['selectedLanguage'] as String,
                      onLanguageChanged: _handleLanguageChange,
                    ),

                    // Footer Section
                    FooterSectionWidget(
                      appVersion: '1.2.3',
                      onTermsTap: () =>
                          _showFeedback('Nutzungsbedingungen geöffnet'),
                      onPrivacyPolicyTap: () =>
                          _showFeedback('Datenschutzerklärung geöffnet'),
                      onLogoutTap: _handleLogout,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Logout Animation Overlay
          if (_isLoggingOut)
            AnimatedBuilder(
              animation: _logoutAnimationController,
              builder: (context, child) {
                return Container(
                  color: Colors.black.withValues(alpha: 0.8),
                  child: Center(
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            (userData['name'] as String)
                                .split(' ')
                                .map((name) => name[0])
                                .join(''),
                            style: AppTheme.lightTheme.textTheme.headlineMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
