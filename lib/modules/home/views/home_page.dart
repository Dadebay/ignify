import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconly/iconly.dart';
import 'package:makc/core/constants/icon_constants.dart';
import 'package:makc/core/constants/image_constants.dart';
import 'package:makc/modules/chat/views/chat_page.dart';
import 'package:makc/modules/notification/views/notification_page.dart';

class ActivityModel {
  final String title;
  final String subtitle;
  final String timeRange;
  final String personName;
  final String imagePath;
  final Color statusColor;
  final String section; // 'Today / Wednesday' or 'November 28 / Friday'
  final List<String> owners; // 'Nathan', 'Alex', 'Max'
  final String category; // 'Classes', 'Events'

  ActivityModel({
    required this.title,
    required this.subtitle,
    required this.timeRange,
    required this.personName,
    required this.imagePath,
    required this.statusColor,
    required this.section,
    required this.owners,
    required this.category,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = 'All';
  String _selectedCategoryFilter = 'All'; // 'All', 'Classes', 'Events'

  final List<ActivityModel> _allActivities = [
    // Today
    ActivityModel(
      title: "Young DaVinci's Drawing",
      subtitle: "The Creative Canvas Art School",
      timeRange: "4:00 PM - 5:00 PM",
      personName: "Ms. Elara Vance",
      imagePath: ImageConstants.featured,
      statusColor: Color(0xFF00C853),
      section: 'Today / Wednesday',
      owners: ['Nathan'],
      category: 'Classes',
    ),
    ActivityModel(
      title: "Twinkle Toes Ballet",
      subtitle: "Little Stars Dance Academy",
      timeRange: "3:45 PM - 4:30 PM",
      personName: "Ms. Clara Beaumont",
      imagePath: ImageConstants.featured1,
      statusColor: Color(0xFFE91E63),
      section: 'Today / Wednesday',
      owners: ['Alex'],
      category: 'Classes',
    ),
    // Friday
    ActivityModel(
      title: "Piano Explorers (Ages 5-7)",
      subtitle: "Harmony House Music Lessons",
      timeRange: "4:00 PM - 5:00 PM",
      personName: "Mr. Dwayne \"DJ\" Jenkins",
      imagePath: ImageConstants.featured2,
      statusColor: Color(0xFFFFC107),
      section: 'November 28 / Friday',
      owners: ['Alex'],
      category: 'Classes',
    ),
    ActivityModel(
      title: "LEGO Robotics I (Ages 7-10)",
      subtitle: "The STEM Lab Robotics & Coding",
      timeRange: "4:30 PM - 5:30 PM",
      personName: "Dr. Ben Carter",
      imagePath: ImageConstants.featured3,
      statusColor: Color(0xFFE91E63),
      section: 'November 28 / Friday',
      owners: ['Alex'],
      category: 'Events',
    ),
  ];

  List<ActivityModel> get _filteredActivities {
    return _allActivities.where((activity) {
      final matchesPerson = _selectedFilter == 'All' || activity.owners.contains(_selectedFilter);
      final matchesCategory = _selectedCategoryFilter == 'All' || activity.category == _selectedCategoryFilter;
      return matchesPerson && matchesCategory;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  _buildFilterOption('All', setModalState),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildFilterOption('Classes', setModalState),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildFilterOption('Events', setModalState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOption(String category, StateSetter setModalState) {
    final isSelected = _selectedCategoryFilter == category;
    return InkWell(
      onTap: () {
        setModalState(() {
          setState(() {
            _selectedCategoryFilter = category;
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E88E5) : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E88E5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              category,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Group filtered activities by section to maintain headers
    final groupedActivities = <String, List<ActivityModel>>{};
    for (var activity in _filteredActivities) {
      if (!groupedActivities.containsKey(activity.section)) {
        groupedActivities[activity.section] = [];
      }
      groupedActivities[activity.section]!.add(activity);
    }

    // Ensure headers order
    final sectionsOrder = ['Today / Wednesday', 'November 28 / Friday'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '👋 Hi, Nathan!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(IconlyLight.chat, color: Colors.black),
                          onPressed: () => Get.to(() => ChatPage()),
                        ),
                        IconButton(
                          icon: const Icon(IconlyLight.notification, color: Colors.black),
                          onPressed: () => Get.to(() => NotificationPage()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Cards Row
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        icon: IconlyLight.calendar,
                        title: 'Schedule',
                        subtitle: "See what's happening",
                        color: const Color(0xFFF5F7FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoCard(
                        icon: IconlyLight.profile,
                        title: 'Check In',
                        subtitle: 'Check in to your family members',
                        color: const Color(0xFFF5F7FF),
                      ),
                    ),
                  ],
                ),
              ),
              // Promotional Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF3FA),
                  border: Border.all(color: const Color(0xFFE9D6FF)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0, top: 6),
                          child: SvgPicture.asset(IconConstants.aiIcon, color: const Color(0xFF972AF7)),
                        ),
                        Expanded(
                          child: const Text(
                            'Based on your progress, try "Advanced Harmony" next to strengthen your composition skills.',
                            style: TextStyle(
                              color: Color(0xFF972AF7),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF972AF7),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Explore studios', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),

              // Upcoming Activities Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming activities',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      // Added GestureDetector for onTap
                      onTap: _showFilterBottomSheet,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]),
                        child: Image.asset(IconConstants.filter, width: 20, height: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Person Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildPersonFilter('All', IconConstants.users, Color(0xFFE3F2FD), Color(0xFF1E88E5)),
                    const SizedBox(width: 12),
                    _buildPersonFilter('Nathan', IconConstants.user, Color(0xFFFFEBEE), Color(0xFFE91E63)),
                    const SizedBox(width: 12),
                    _buildPersonFilter('Alex', IconConstants.user, Color(0xFFE8F5E9), Color(0xFF4CAF50)),
                    const SizedBox(width: 12),
                    _buildPersonFilter('Max', IconConstants.user, Color(0xFFFFF8E1), Color(0xFFFFC107)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Dynamic Layout based on grouped activities
              ...sectionsOrder.map((section) {
                final activities = groupedActivities[section];
                if (activities == null || activities.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        section,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: activities.map((activity) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: _buildActivityCard(
                              title: activity.title,
                              subtitle: activity.subtitle,
                              timeRange: activity.timeRange,
                              personName: activity.personName,
                              imagePath: activity.imagePath,
                              statusColor: activity.statusColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 130,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF7B68EE)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonFilter(String name, String iconPath, Color bgColor, Color textColor) {
    final bool isSelected = _selectedFilter == name;
    // Visually emphasize selection: If selected, use the color. If not, maybe grey out or keep as is?
    // Design shows them colored. Let's make unselected ones semi-transparent or just distinct.
    // Actually per design images, it looks like they are always colored but maybe opacity changes
    // or maybe the border appears?
    // Let's assume standard behavior: Opacity or border.
    // For now, I'll add a border if selected, or slightly dim if not.
    // Or, cleaner: If selected, full opacity. If not, 0.5 opacity.

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = name;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? bgColor : bgColor.withOpacity(0.5), // Dim inactive
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: textColor, width: 2) : Border.all(color: Colors.transparent, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, width: 16, height: 16, color: textColor),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String subtitle,
    required String timeRange,
    required String personName,
    required String imagePath,
    required Color statusColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 90,
                height: 90,
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey[500]),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: statusColor, width: 2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Image.asset(IconConstants.chart, width: 14, height: 14, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Image.asset(IconConstants.clock, width: 14, height: 14, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    timeRange,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Image.asset(IconConstants.user, width: 14, height: 14, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    personName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
