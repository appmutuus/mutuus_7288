import 'package:flutter/material.dart';
import '../presentation/settings_and_account/settings_and_account.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/job_application/job_application.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/register_screen/register_screen.dart';
import '../presentation/digital_wallet/digital_wallet.dart';
import '../presentation/job_details/job_details.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String settingsAndAccount = '/settings-and-account';
  static const String homeDashboard = '/home-dashboard';
  static const String jobApplication = '/job-application';
  static const String login = '/login-screen';
  static const String digitalWallet = '/digital-wallet';
  static const String jobDetails = '/job-details';
  static const String register = '/register-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    settingsAndAccount: (context) => const SettingsAndAccount(),
    homeDashboard: (context) => const HomeDashboard(),
    jobApplication: (context) => const JobApplication(),
    login: (context) => const LoginScreen(),
    digitalWallet: (context) => const DigitalWallet(),
    jobDetails: (context) => const JobDetails(),
    register: (context) => const RegisterScreen(),
    // TODO: Add your other routes here
  };
}
