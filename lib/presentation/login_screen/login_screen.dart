import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/app_logo_widget.dart';
import './widgets/google_login_button_widget.dart';
import './widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isGoogleLoading = false;
  bool _isEmailLoading = false;
  final FocusNode _focusNode = FocusNode();

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'admin@mutuus.de': 'admin123',
    'user@mutuus.de': 'user123',
    'helper@mutuus.de': 'helper123',
  };

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleLogin() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      // Simulate Google OAuth process
      await Future.delayed(const Duration(seconds: 2));

      // Haptic feedback for success
      HapticFeedback.lightImpact();

      if (mounted) {
        _navigateToHome();
      }
    } catch (e) {
      if (mounted) {
        _showErrorMessage(
            'Google-Anmeldung fehlgeschlagen. Bitte versuchen Sie es erneut.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

  Future<void> _handleEmailLogin(String email, String password) async {
    setState(() {
      _isEmailLoading = true;
    });

    try {
      // Simulate authentication delay
      await Future.delayed(const Duration(seconds: 1));

      // Check mock credentials
      if (_mockCredentials.containsKey(email) &&
          _mockCredentials[email] == password) {
        // Haptic feedback for success
        HapticFeedback.lightImpact();

        if (mounted) {
          _navigateToHome();
        }
      } else {
        if (mounted) {
          _showErrorMessage(
              'Ungültige E-Mail-Adresse oder Passwort. Bitte überprüfen Sie Ihre Eingaben.');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorMessage(
            'Anmeldung fehlgeschlagen. Bitte versuchen Sie es erneut.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isEmailLoading = false;
        });
      }
    }
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home-dashboard',
      (route) => false,
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      body: SafeArea(
        child: GestureDetector(
          onTap: _dismissKeyboard,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8.h),

                    // App Logo Section
                    const AppLogoWidget(),

                    SizedBox(height: 6.h),

                    // Welcome Text
                    Text(
                      'Willkommen zurück!',
                      textAlign: TextAlign.center,
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'Melden Sie sich an, um lokale Jobs zu finden und Aufgaben zu erledigen',
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Google Login Button
                    GoogleLoginButtonWidget(
                      onGoogleLogin: _handleGoogleLogin,
                      isLoading: _isGoogleLoading,
                    ),

                    SizedBox(height: 3.h),

                    // Divider with "oder"
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppTheme.lightTheme.colorScheme.outline,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            'oder',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppTheme.lightTheme.colorScheme.outline,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 3.h),

                    // Email/Password Login Form
                    LoginFormWidget(
                      onLogin: _handleEmailLogin,
                      isLoading: _isEmailLoading,
                    ),

                    SizedBox(height: 4.h),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Noch kein Konto? ',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        TextButton(
                          onPressed: (_isGoogleLoading || _isEmailLoading)
                              ? null
                              : () {
                                  // Handle sign up navigation
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Registrierung wird bald verfügbar sein'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Registrieren',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
