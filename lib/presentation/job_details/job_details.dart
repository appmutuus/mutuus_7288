import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/application_button_widget.dart';
import './widgets/client_profile_widget.dart';
import './widgets/job_deadline_widget.dart';
import './widgets/job_description_widget.dart';
import './widgets/job_header_widget.dart';
import './widgets/job_info_widget.dart';
import './widgets/job_location_widget.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({Key? key}) : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  bool _isSaved = false;
  bool _isLoading = false;

  // Mock job data
  final Map<String, dynamic> _jobData = {
    "id": 1,
    "title": "Hilfe beim Umzug - 2 Zimmer Wohnung",
    "description":
        """Ich benötige Hilfe beim Umzug meiner 2-Zimmer Wohnung. Der Umzug findet am Wochenende statt und ich suche 2-3 zuverlässige Helfer.

Die Wohnung befindet sich im 3. Stock ohne Aufzug, die neue Wohnung im 2. Stock mit Aufzug. Es sind hauptsächlich Möbel, Kartons und Haushaltsgeräte zu transportieren.

Ein Transporter ist bereits organisiert. Getränke und Verpflegung werden gestellt. Die Arbeit sollte etwa 4-6 Stunden dauern.""",
    "category": "Umzug & Transport",
    "payment_type": "cash",
    "payment_amount": 120.0,
    "karma_points": null,
    "is_urgent": true,
    "is_premium": false,
    "minimum_rank": 2,
    "address": "Musterstraße 123",
    "city": "München",
    "distance": 2.3,
    "deadline": "2025-08-15T18:00:00.000Z",
    "created_at": "2025-08-10T10:30:00.000Z",
    "status": "active",
    "has_applied": false,
    "requirements": [
      "Körperlich fit und belastbar",
      "Pünktlichkeit und Zuverlässigkeit",
      "Erfahrung mit Umzügen von Vorteil",
      "Eigene Arbeitshandschuhe mitbringen"
    ],
    "images": [
      "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
    ],
    "client": {
      "id": 1,
      "name": "Maria Schmidt",
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "rating": 4.8,
      "completed_jobs": 23,
      "is_verified": true,
      "is_kyc_verified": true,
      "member_since": "2023-03-15T00:00:00.000Z",
      "response_time": "2",
      "badges": ["Zuverlässiger Auftraggeber", "Schnelle Zahlung", "Freundlich"]
    }
  };

  // Mock user data
  final Map<String, dynamic> _userData = {
    "id": 1,
    "name": "Max Mustermann",
    "rank": 3,
    "is_premium": false,
    "karma_points": 150
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            slivers: [
              // Header with Image and Navigation
              JobHeaderWidget(
                jobData: _jobData,
                onBackPressed: _handleBackPressed,
                onSharePressed: _handleSharePressed,
                onReportPressed: _handleReportPressed,
                onSavePressed: _handleSavePressed,
                isSaved: _isSaved,
              ),

              // Job Information
              SliverToBoxAdapter(
                child: JobInfoWidget(jobData: _jobData),
              ),

              // Job Description
              SliverToBoxAdapter(
                child: JobDescriptionWidget(jobData: _jobData),
              ),

              // Location Information
              SliverToBoxAdapter(
                child: JobLocationWidget(
                  jobData: _jobData,
                  onNavigatePressed: _handleNavigatePressed,
                ),
              ),

              // Deadline Information
              SliverToBoxAdapter(
                child: JobDeadlineWidget(jobData: _jobData),
              ),

              // Client Profile
              SliverToBoxAdapter(
                child: ClientProfileWidget(
                  clientData: _jobData['client'] as Map<String, dynamic>,
                  onProfileTap: _handleClientProfileTap,
                ),
              ),

              // Bottom Padding for Fixed Button
              SliverToBoxAdapter(
                child: SizedBox(height: 20.h),
              ),
            ],
          ),

          // Fixed Application Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ApplicationButtonWidget(
              jobData: _jobData,
              userData: _userData,
              onApplyPressed: _handleApplyPressed,
              onUpgradePressed: _handleUpgradePressed,
            ),
          ),

          // Loading Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _handleBackPressed() {
    Navigator.pop(context);
  }

  void _handleSharePressed() {
    // Generate deep link for referral tracking
    final String shareText = '''
Schau dir diesen Job an: ${_jobData['title']}

💰 ${_jobData['payment_type'] == 'karma' ? '${_jobData['karma_points']} Karma' : '€${_jobData['payment_amount']}'}
📍 ${_jobData['city']}
⏰ Deadline: ${_formatDeadline(_jobData['deadline'] as String)}

Jetzt in der Mutuus App bewerben!
''';

    Fluttertoast.showToast(
      msg: "Link kopiert! $shareText",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleReportPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Job melden',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Möchten Sie diesen Job wegen unangemessener Inhalte melden?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Abbrechen',
              style: AppTheme.lightTheme.textTheme.labelLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: "Job wurde gemeldet",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorLight,
            ),
            child: Text(
              'Melden',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSavePressed() {
    setState(() {
      _isSaved = !_isSaved;
    });

    Fluttertoast.showToast(
      msg: _isSaved ? "Job gespeichert" : "Job entfernt",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleNavigatePressed() {
    Fluttertoast.showToast(
      msg: "Navigation zu ${_jobData['address']}, ${_jobData['city']}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleClientProfileTap() {
    Fluttertoast.showToast(
      msg:
          "Profil von ${(_jobData['client'] as Map<String, dynamic>)['name']} öffnen",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleApplyPressed() {
    // Check eligibility
    if (!_checkEligibility()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.pushNamed(context, '/job-application');
    });
  }

  void _handleUpgradePressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'star',
              color: AppTheme.warningLight,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Premium Upgrade',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upgrade auf Premium für nur €14,99/Monat und erhalte:',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 2.h),
            _buildPremiumFeature('Zugang zu Premium-Jobs'),
            _buildPremiumFeature('Reduzierte Gebühren (5% statt 9,8%)'),
            _buildPremiumFeature('Exklusive Inhalte'),
            _buildPremiumFeature('Prioritäts-Support'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Später',
              style: AppTheme.lightTheme.textTheme.labelLarge,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: "Premium-Upgrade wird geöffnet",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
            child: Text(
              'Jetzt upgraden',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumFeature(String feature) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'check_circle',
            color: AppTheme.successLight,
            size: 16,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              feature,
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  bool _checkEligibility() {
    final bool isExpired =
        DateTime.now().isAfter(DateTime.parse(_jobData['deadline'] as String));
    final bool isFilled = _jobData['status'] == 'filled';
    final bool hasApplied = _jobData['has_applied'] ?? false;
    final bool isPremiumJob = _jobData['is_premium'] ?? false;
    final bool isUserPremium = _userData['is_premium'] ?? false;
    final bool meetsRankRequirement =
        (_userData['rank'] ?? 1) >= (_jobData['minimum_rank'] ?? 1);

    if (isExpired || isFilled || hasApplied) return false;
    if (isPremiumJob && !isUserPremium) return false;
    if (!meetsRankRequirement) return false;

    return true;
  }

  String _formatDeadline(String deadline) {
    final DateTime date = DateTime.parse(deadline);
    final List<String> months = [
      'Jan',
      'Feb',
      'Mär',
      'Apr',
      'Mai',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Okt',
      'Nov',
      'Dez'
    ];

    return '${date.day}. ${months[date.month - 1]} ${date.year}';
  }
}
