import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RotatingBannerWidget extends StatefulWidget {
  const RotatingBannerWidget({Key? key}) : super(key: key);

  @override
  State<RotatingBannerWidget> createState() => _RotatingBannerWidgetState();
}

class _RotatingBannerWidgetState extends State<RotatingBannerWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _banners = [
    {
      "type": "achievement",
      "title": "Glückwunsch!",
      "subtitle": "Du hast den Bronze-Rang erreicht",
      "icon": "emoji_events",
      "color": Color(0xFFD97706),
      "action": "Belohnungen ansehen"
    },
    {
      "type": "learning",
      "title": "Campus Lektion verfügbar",
      "subtitle": "Lerne über Zeitmanagement",
      "icon": "school",
      "color": Color(0xFF059669),
      "action": "Jetzt lernen"
    },
    {
      "type": "premium",
      "title": "Premium upgraden",
      "subtitle": "Nur 5% Gebühren statt 9,8%",
      "icon": "workspace_premium",
      "color": Color(0xFF2563EB),
      "action": "Upgrade für €14,99"
    }
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoRotation();
  }

  void _startAutoRotation() {
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _banners.length;
        });
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAutoRotation();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: _banners.length,
        itemBuilder: (context, index) {
          final banner = _banners[index];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (banner["color"] as Color).withValues(alpha: 0.1),
                  (banner["color"] as Color).withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (banner["color"] as Color).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: banner["color"] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: banner["icon"] as String,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          banner["title"] as String,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: banner["color"] as Color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          banner["subtitle"] as String,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: banner["color"] as Color,
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
