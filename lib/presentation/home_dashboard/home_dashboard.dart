import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/karma_service.dart';
import '../../services/notification_service.dart';
import './widgets/empty_state_widget.dart';
import './widgets/greeting_header_widget.dart';
import './widgets/job_card_widget.dart';
import './widgets/rotating_banner_widget.dart';
import './widgets/section_header_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  bool _isRefreshing = false;
  int _selectedTabIndex = 0;

  // Mock user data
  final Map<String, dynamic> _userData = {
    "name": "Max Müller",
    "avatar":
        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
    "currentRank": "Bronze",
    "karmaPoints": 245,
  };

  // Mock job data
  final List<Map<String, dynamic>> _recommendedJobs = [
    {
      "id": 1,
      "title": "Möbel aufbauen in Schwabing",
      "description":
          "Ich brauche Hilfe beim Aufbau eines IKEA Kleiderschranks. Werkzeug ist vorhanden, dauert ca. 2-3 Stunden.",
      "category": "Handwerk",
      "categoryIcon": "build",
      "paymentType": "money",
      "price": "45.00",
      "distance": 2.3,
      "deadline": "Heute 18:00",
      "requiredRank": "Bronze",
      "isPremium": false,
    },
    {
      "id": 2,
      "title": "Einkaufen für ältere Dame",
      "description":
          "Wöchentlicher Einkauf im Supermarkt. Liste wird bereitgestellt. Auto von Vorteil aber nicht zwingend nötig.",
      "category": "Einkaufen",
      "categoryIcon": "shopping_cart",
      "paymentType": "money",
      "price": "25.00",
      "distance": 1.8,
      "deadline": "Morgen 14:00",
      "requiredRank": null,
      "isPremium": true,
    },
    {
      "id": 3,
      "title": "Hund Gassi führen",
      "description":
          "Mein Golden Retriever Bruno braucht täglich 1 Stunde Auslauf. Er ist sehr freundlich und gut erzogen.",
      "category": "Tiere",
      "categoryIcon": "pets",
      "paymentType": "karma",
      "karmaPoints": 50,
      "distance": 0.9,
      "deadline": "Täglich 16:00",
      "requiredRank": "Bronze",
      "isPremium": false,
    },
  ];

  final List<Map<String, dynamic>> _nearbyJobs = [
    {
      "id": 4,
      "title": "Garten umgraben",
      "description":
          "Kleiner Garten (ca. 20m²) muss für die neue Saison vorbereitet werden. Spaten und Harke sind da.",
      "category": "Garten",
      "categoryIcon": "grass",
      "paymentType": "money",
      "price": "60.00",
      "distance": 0.5,
      "deadline": "Wochenende",
      "requiredRank": "Silber",
      "isPremium": true,
    },
    {
      "id": 5,
      "title": "Computer einrichten",
      "description":
          "Neuen Laptop einrichten, Programme installieren und Daten übertragen. Grundkenntnisse erforderlich.",
      "category": "IT",
      "categoryIcon": "computer",
      "paymentType": "money",
      "price": "40.00",
      "distance": 1.2,
      "deadline": "Diese Woche",
      "requiredRank": "Bronze",
      "isPremium": false,
    },
  ];

  final List<Map<String, dynamic>> _newJobs = [
    {
      "id": 6,
      "title": "Umzugshilfe gesucht",
      "description":
          "2-Zimmer Wohnung, 3. Stock ohne Aufzug. Starke Helfer gesucht. LKW ist organisiert.",
      "category": "Umzug",
      "categoryIcon": "local_shipping",
      "paymentType": "money",
      "price": "80.00",
      "distance": 3.1,
      "deadline": "Samstag 09:00",
      "requiredRank": "Bronze",
      "isPremium": false,
    },
  ];

  Future<void> _loadUserData() async {
    final karma = await KarmaService.getKarma();
    setState(() {
      _userData['karmaPoints'] = karma;
      _userData['currentRank'] = KarmaService.rankForKarma(karma);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 5, vsync: this);
    _loadUserData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _navigateToJobDetails(Map<String, dynamic> job) {
    Navigator.pushNamed(context, '/job-details');
  }

  void _navigateToJobApplication(Map<String, dynamic> job) {
    Navigator.pushNamed(context, '/job-application');
  }

  void _createNewJob() {
    final newJob = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'title': 'Nachbarschaftshilfe',
      'description': 'Hilf einem Nachbarn beim Einkauf.',
      'category': 'Hilfe',
      'categoryIcon': 'favorite',
      'paymentType': 'karma',
      'karmaPoints': 30,
      'distance': 0.0,
      'deadline': 'Heute',
      'requiredRank': 'Starter',
      'isPremium': false,
    };
    setState(() {
      _newJobs.add(newJob);
    });
    NotificationService.show('Neuer Karma-Job erstellt: ${newJob['title']}');
  }

  void _showMainMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  margin: EdgeInsets.only(top: 2.h, bottom: 1.h),
                  width: 12.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Menu title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    'Menü',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                // Menu items
                _buildMenuItem('Startseite', 'home', () {
                  Navigator.pop(context);
                  // Already on home, just close menu
                }),
                _buildMenuItem('Jobs', 'work', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Jobs screen
                }),
                _buildMenuItem('Profil', 'person', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Profile screen
                }),
                _buildMenuItem('Wallet', 'account_balance_wallet', () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/digital-wallet');
                }),
                _buildMenuItem('Community', 'group', () {
                  Navigator.pop(context);
                  // TODO: Navigate to Community screen
                }),
                _buildMenuItem('Einstellungen', 'settings', () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings-and-account');
                }),
                
                // Premium button
                Container(
                  margin: EdgeInsets.all(4.w),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Premium Upsell action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.warningLight,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Premium werden',
                          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String title, String icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: icon,
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobSection({
    required String title,
    required List<Map<String, dynamic>> jobs,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    if (jobs.isEmpty) {
      return Column(
        children: [
          SectionHeaderWidget(
            title: title,
            actionText: actionText,
            onActionTap: onActionTap,
          ),
          EmptyStateWidget(
            title: "Keine Jobs verfügbar",
            subtitle:
                "Schau später wieder vorbei oder erstelle deinen ersten Job.",
            buttonText: "Ersten Job erstellen",
            onButtonPressed: _createNewJob,
          ),
        ],
      );
    }

    return Column(
      children: [
        SectionHeaderWidget(
          title: title,
          actionText: actionText,
          onActionTap: onActionTap,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return JobCardWidget(
              job: job,
              onTap: () => _navigateToJobDetails(job),
              onApply: () => _navigateToJobApplication(job),
              onSave: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Job gespeichert')),
                );
              },
              onShare: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Job geteilt')),
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Greeting Header
            GreetingHeaderWidget(
              userName: _userData["name"] as String,
              userAvatar: _userData["avatar"] as String,
              currentRank: _userData["currentRank"] as String,
              karmaPoints: _userData["karmaPoints"] as int,
            ),

            // Main Content with Pull-to-Refresh
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: AppTheme.lightTheme.primaryColor,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // Rotating Banner
                    SliverToBoxAdapter(
                      child: RotatingBannerWidget(),
                    ),

                    // Recommended Jobs Section
                    SliverToBoxAdapter(
                      child: _buildJobSection(
                        title: "Empfohlene Jobs",
                        jobs: _recommendedJobs,
                        actionText: "Alle anzeigen",
                        onActionTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Alle empfohlenen Jobs anzeigen')),
                          );
                        },
                      ),
                    ),

                    // Nearby Jobs Section
                    SliverToBoxAdapter(
                      child: _buildJobSection(
                        title: "In der Nähe",
                        jobs: _nearbyJobs,
                        actionText: "Umkreis ändern",
                        onActionTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Umkreis-Einstellungen öffnen')),
                          );
                        },
                      ),
                    ),

                    // New Jobs Section
                    SliverToBoxAdapter(
                      child: _buildJobSection(
                        title: "Neue Aufträge",
                        jobs: _newJobs,
                        actionText: "Filter",
                        onActionTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Filter-Optionen öffnen')),
                          );
                        },
                      ),
                    ),

                    // Bottom spacing
                    SliverToBoxAdapter(
                      child: SizedBox(height: 10.h),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:
                  AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.lightTheme.cardColor,
          selectedItemColor: AppTheme.lightTheme.primaryColor,
          unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: _selectedTabIndex == 0 ? 'home' : 'home',
                color: _selectedTabIndex == 0 
                    ? AppTheme.lightTheme.primaryColor 
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: _selectedTabIndex == 1 ? 'work' : 'work',
                color: _selectedTabIndex == 1 
                    ? AppTheme.lightTheme.primaryColor 
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: _selectedTabIndex == 2 ? 'menu' : 'menu',
                color: _selectedTabIndex == 2 
                    ? AppTheme.lightTheme.primaryColor 
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Menü',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: _selectedTabIndex == 3 ? 'person' : 'person',
                color: _selectedTabIndex == 3 
                    ? AppTheme.lightTheme.primaryColor 
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: _selectedTabIndex == 4 ? 'settings' : 'settings',
                color: _selectedTabIndex == 4 
                    ? AppTheme.lightTheme.primaryColor 
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Einstellungen',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedTabIndex = index;
            });

            // Navigate to respective screens
            switch (index) {
              case 0:
                // Already on Home
                break;
              case 1:
                // TODO: Navigate to Jobs screen
                break;
              case 2:
                // Open Menu
                _showMainMenu();
                break;
              case 3:
                // TODO: Navigate to Profile screen
                break;
              case 4:
                // Navigate to Einstellungen
                Navigator.pushNamed(context, '/settings-and-account');
                break;
            }
          },
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewJob,
        backgroundColor: AppTheme.lightTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 24,
        ),
        label: Text(
          'Job erstellen',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
