import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/app_export.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  bool _agreed = false;

  final Uri _privacyUrl =
      Uri.parse('https://mutuus-app.de/pages/Datenschutz.html');
  final Uri _termsUrl =
      Uri.parse('https://mutuus-app.de/pages/AGB.html');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kann URL nicht öffnen: $url')),
      );
    }
  }

  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false) || !_agreed) {
      if (!_agreed) {
        _showError('Bitte stimme der Datenschutzerklärung und den AGB zu.');
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      final res = await SupabaseService.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        name: _nameController.text.trim(),
      );
      if (res.user != null) {
        HapticFeedback.lightImpact();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Registrierung erfolgreich. Bitte bestätige deine E-Mail.'),
              duration: Duration(seconds: 4),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        _showError(res.error?.message ?? 'Registrierung fehlgeschlagen.');
      }
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Registrierung fehlgeschlagen. Bitte versuche es erneut.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Registrieren'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Name ist erforderlich' : null,
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: _emailController,
                  decoration:
                      const InputDecoration(labelText: 'E-Mail-Adresse'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'E-Mail-Adresse ist erforderlich';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(v)) {
                      return 'Bitte gültige E-Mail-Adresse eingeben';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Passwort'),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Passwort ist erforderlich';
                    }
                    if (v.length < 6) {
                      return 'Passwort muss mindestens 6 Zeichen enthalten';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: _confirmController,
                  decoration:
                      const InputDecoration(labelText: 'Passwort bestätigen'),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Bitte Passwort bestätigen';
                    }
                    if (v != _passwordController.text) {
                      return 'Passwörter stimmen nicht überein';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _agreed,
                      onChanged: (v) => setState(() => _agreed = v ?? false),
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          const Text('Ich stimme der '),
                          GestureDetector(
                            onTap: () => _openUrl(_privacyUrl),
                            child: Text(
                              'Datenschutzerklärung',
                              style: TextStyle(
                                color: AppTheme
                                    .lightTheme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const Text(' und den '),
                          GestureDetector(
                            onTap: () => _openUrl(_termsUrl),
                            child: Text(
                              'AGB',
                              style: TextStyle(
                                color: AppTheme
                                    .lightTheme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const Text(' zu.'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    child: _isLoading
                        ? SizedBox(
                            width: 5.w,
                            height: 5.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.lightTheme.colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : const Text('Registrieren'),
                  ),
                ),
                SizedBox(height: 2.h),
                TextButton(
                  onPressed:
                      _isLoading ? null : () => Navigator.pop(context),
                  child: const Text('Schon ein Konto? Anmelden'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

