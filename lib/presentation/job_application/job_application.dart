import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/application_terms_section.dart';
import './widgets/availability_section.dart';
import './widgets/job_summary_card.dart';
import './widgets/personal_message_section.dart';
import './widgets/portfolio_upload_section.dart';
import './widgets/submit_application_button.dart';

class JobApplication extends StatefulWidget {
  const JobApplication({Key? key}) : super(key: key);

  @override
  State<JobApplication> createState() => _JobApplicationState();
}

class _JobApplicationState extends State<JobApplication>
    with TickerProviderStateMixin {
  // Form controllers and state
  final TextEditingController _messageController = TextEditingController();
  DateTime? _selectedStartDate;
  String _selectedTimePreference = "";
  List<XFile> _selectedImages = [];
  bool _isTermsAccepted = false;
  bool _isSubmitting = false;

  // Auto-save timer
  Timer? _autoSaveTimer;

  // Animation controllers
  late AnimationController _celebrationController;
  late Animation<double> _celebrationAnimation;

  // Mock job data
  final Map<String, dynamic> jobData = {
    "id": 1,
    "title": "Wohnungsreinigung nach Umzug",
    "description":
        "Suche zuverlässige Person für gründliche Reinigung einer 3-Zimmer-Wohnung nach Umzug. Alle Räume, Küche und Bad müssen gereinigt werden.",
    "category": "Haushaltsservice",
    "location": "München, Bayern",
    "price": "120,00",
    "paymentType": "paid",
    "karmaPoints": 0,
    "deadline": "25.08.2025",
    "minRank": 2,
    "isPremium": false,
    "clientId": 101,
    "clientName": "Anna Schmidt",
    "clientRating": 4.8,
    "postedDate": "2025-08-10",
  };

  // Mock user data for eligibility checks
  final Map<String, dynamic> currentUser = {
    "id": 201,
    "name": "Max Mustermann",
    "email": "max.mustermann@email.com",
    "rank": 3,
    "isPremium": false,
    "karmaPoints": 150,
    "completedJobs": 12,
    "rating": 4.6,
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAutoSave();
    _performEligibilityChecks();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _autoSaveTimer?.cancel();
    _celebrationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _celebrationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _celebrationController,
      curve: Curves.elasticOut,
    ));
  }

  void _startAutoSave() {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _saveDraft();
    });
  }

  void _saveDraft() {
    // Auto-save functionality - in real app would save to local storage
    if (_messageController.text.isNotEmpty ||
        _selectedStartDate != null ||
        _selectedTimePreference.isNotEmpty ||
        _selectedImages.isNotEmpty) {
      // Save draft logic here
      debugPrint("Draft saved automatically");
    }
  }

  void _performEligibilityChecks() {
    // Check minimum rank requirement
    if ((currentUser["rank"] as int) < (jobData["minRank"] as int)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showEligibilityError(
          "Rang zu niedrig",
          "Sie benötigen mindestens Rang ${jobData["minRank"]} für diese Aufgabe. Ihr aktueller Rang: ${currentUser["rank"]}",
        );
      });
      return;
    }

    // Check premium job access
    if ((jobData["isPremium"] as bool) && !(currentUser["isPremium"] as bool)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showEligibilityError(
          "Premium-Mitgliedschaft erforderlich",
          "Diese Aufgabe ist nur für Premium-Mitglieder verfügbar. Upgraden Sie Ihr Konto für Zugang zu exklusiven Jobs.",
        );
      });
      return;
    }

    // Check for duplicate application (mock check)
    // In real app, this would check against backend
    final hasApplied = false; // Mock value
    if (hasApplied) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showEligibilityError(
          "Bereits beworben",
          "Sie haben sich bereits für diese Aufgabe beworben. Mehrfachbewerbungen sind nicht erlaubt.",
        );
      });
      return;
    }
  }

  void _showEligibilityError(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'error',
              color: AppTheme.errorLight,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text("Verstanden"),
          ),
        ],
      ),
    );
  }

  bool _isFormValid() {
    return _selectedStartDate != null &&
        _selectedTimePreference.isNotEmpty &&
        _isTermsAccepted;
  }

  Future<void> _submitApplication() async {
    if (!_isFormValid() || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock application data
      final applicationData = {
        "jobId": jobData["id"],
        "applicantId": currentUser["id"],
        "message": _messageController.text.trim(),
        "startDate": _selectedStartDate?.toIso8601String(),
        "timePreference": _selectedTimePreference,
        "portfolioImages": _selectedImages.map((img) => img.path).toList(),
        "submittedAt": DateTime.now().toIso8601String(),
        "status": "pending",
      };

      debugPrint("Application submitted: $applicationData");

      // Show success animation
      await _showSuccessAnimation();

      // Navigate to applications screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-dashboard');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(
            "Fehler beim Senden der Bewerbung. Bitte versuchen Sie es erneut.");
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _showSuccessAnimation() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AnimatedBuilder(
        animation: _celebrationAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _celebrationAnimation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Container(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.successLight.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.successLight,
                        size: 48,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Bewerbung gesendet!",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.successLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Ihre Bewerbung wurde erfolgreich an den Auftraggeber gesendet. Sie erhalten eine Benachrichtigung, sobald eine Antwort vorliegt.",
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    _celebrationController.forward();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'error',
              color: AppTheme.errorLight,
              size: 24,
            ),
            SizedBox(width: 2.w),
            const Text("Fehler"),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_messageController.text.isNotEmpty ||
        _selectedStartDate != null ||
        _selectedTimePreference.isNotEmpty ||
        _selectedImages.isNotEmpty) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Bewerbung verlassen?"),
          content: const Text(
              "Ihre Eingaben gehen verloren, wenn Sie jetzt verlassen. Möchten Sie wirklich fortfahren?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Abbrechen"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                "Verlassen",
                style: TextStyle(color: AppTheme.errorLight),
              ),
            ),
          ],
        ),
      );

      return shouldPop ?? false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text("Bewerbung"),
          leading: IconButton(
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.pop(context);
              }
            },
            icon: CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          actions: [
            if (_messageController.text.isNotEmpty ||
                _selectedStartDate != null ||
                _selectedTimePreference.isNotEmpty ||
                _selectedImages.isNotEmpty)
              TextButton(
                onPressed: _saveDraft,
                child: Text(
                  "Entwurf",
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 1.h),

              // Job Summary Card
              JobSummaryCard(jobData: jobData),

              SizedBox(height: 1.h),

              // Personal Message Section
              PersonalMessageSection(
                messageController: _messageController,
                onMessageChanged: (value) {
                  setState(() {});
                },
              ),

              // Availability Section
              AvailabilitySection(
                selectedStartDate: _selectedStartDate,
                selectedTimePreference: _selectedTimePreference,
                onStartDateChanged: (date) {
                  setState(() {
                    _selectedStartDate = date;
                  });
                },
                onTimePreferenceChanged: (preference) {
                  setState(() {
                    _selectedTimePreference = preference;
                  });
                },
              ),

              // Portfolio Upload Section
              PortfolioUploadSection(
                selectedImages: _selectedImages,
                onImagesChanged: (images) {
                  setState(() {
                    _selectedImages = images;
                  });
                },
              ),

              // Application Terms Section
              ApplicationTermsSection(
                isTermsAccepted: _isTermsAccepted,
                onTermsChanged: (accepted) {
                  setState(() {
                    _isTermsAccepted = accepted;
                  });
                },
              ),

              // Submit Application Button
              SubmitApplicationButton(
                isFormValid: _isFormValid(),
                isSubmitting: _isSubmitting,
                onSubmit: _submitApplication,
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
