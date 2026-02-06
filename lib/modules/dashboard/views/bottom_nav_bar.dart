import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:makc/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:makc/modules/home/views/home_page.dart';
import 'package:makc/modules/explore/views/explore_page.dart';
import 'package:makc/modules/calendar/views/calendar_page.dart';
import 'package:makc/modules/learning/views/learning_hub_page.dart';
import 'package:makc/modules/account/views/account_page.dart';

class BottomNavBar extends GetView<DashboardController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: const [
              ExplorePage(),
              CalendarPage(),
              HomePage(),
              LearningHubPage(),
              AccountPage(),
            ],
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTabIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.discovery),
              activeIcon: Icon(IconlyBold.discovery),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.calendar),
              activeIcon: Icon(IconlyBold.calendar),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              activeIcon: Icon(IconlyBold.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.category), // Placeholder for Learning/Shapes
              activeIcon: Icon(IconlyBold.category),
              label: 'Learning',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile),
              activeIcon: Icon(IconlyBold.profile),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
