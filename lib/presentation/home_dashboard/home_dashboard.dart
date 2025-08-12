import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 5, vsync: this);
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
    // Navigate to job creation flow
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Job erstellen wird geöffnet...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showMainMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem('Startseite', 'home', () {
                Navigator.pushNamed(context, '/home-dashboard');
              }),
              _buildMenuItem('Jobs', 'search', () {
                // TODO: Navigate to Jobs screen
              }),
              _buildMenuItem('Profil', 'person', () {
                // TODO: Navigate to Profile screen
              }),
              _buildMenuItem('Wallet', 'account_balance_wallet', () {
                Navigator.pushNamed(context, '/digital-wallet');
              }),
              _buildMenuItem('Community', 'group', () {
                // TODO: Navigate to Community screen
              }),
              _buildMenuItem('Einstellungen', 'settings', () {
                Navigator.pushNamed(context, '/settings-and-account');
              }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Premium Upsell action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('Premium werden'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String title, String icon, VoidCallback onTap) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.primaryColor,
      ),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
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
          currentIndex: 0, // Home is active
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.lightTheme.cardColor,
          selectedItemColor: AppTheme.lightTheme.primaryColor,
          unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'home',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'search',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'menu',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Menü',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'person',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
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
                // Navigate to Jobs
                break;
              case 2:
                // Open Menu
                _showMainMenu();
                break;
              case 3:
                // Navigate to Profile
                break;
              case 4:
                // Navigate to Settings
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
