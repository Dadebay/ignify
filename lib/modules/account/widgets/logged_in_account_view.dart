import 'package:flutter/material.dart';
import '../widgets/account_menu_item.dart';
import '../views/simple_page.dart';
import '../../../../core/constants/icon_constants.dart';

class LoggedInAccountView extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? userAvatar;
  final VoidCallback onLogout;

  const LoggedInAccountView({
    super.key,
    required this.userName,
    required this.userEmail,
    this.userAvatar,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // User Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: userAvatar != null ? (userAvatar!.startsWith('http') ? NetworkImage(userAvatar!) : AssetImage(userAvatar!) as ImageProvider) : null,
                  child: userAvatar == null
                      ? Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.grey[600],
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showWorkspaceSelector(context),
                  child: Image.asset(
                    IconConstants.repeat,
                    width: 20,
                    height: 20,
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Profile & Family Section
          // Profile & Family Section
          _buildSectionHeader('Profile & Family'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                AccountMenuItem(
                  iconPath: IconConstants.users,
                  title: 'My family',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'My family'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.document,
                  title: 'Reports',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Reports'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Activity Section
          _buildSectionHeader('Activity'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                AccountMenuItem(
                  iconPath: IconConstants.bookmark,
                  title: 'My Bookings',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'My Bookings'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.heart,
                  title: 'Favorites',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Favorites'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Settings & Support Section
          _buildSectionHeader('Settings & Support'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                AccountMenuItem(
                  iconPath: IconConstants.lang,
// No appropriate asset found in IconConstants
                  title: 'Language',
                  trailing: 'English',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Language'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.bell,
                  title: 'Notification settings',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Notification settings'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.shield,
                  title: 'Security',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Security'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.shieldKeyhole,
                  title: 'Permissions',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Permissions'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.helpAndSupport,
                  title: 'Help & Support',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Help & Support'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.document,
                  title: 'Terms & Conditions',
                  isExternal: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Terms & Conditions'),
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[200], indent: 56, endIndent: 20),
                AccountMenuItem(
                  iconPath: IconConstants.shield3,
                  title: 'Privacy & policy',
                  isExternal: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimplePage(title: 'Privacy & policy'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Log Out
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[50], // Or white depending on exact design preference, but keeping consistent with groups
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: onLogout,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 22,
                      color: Colors.black, // Changed to black as per image
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Changed to black as per image
                      ),
                    ),
                    const Spacer(),
                    // Optional: Add chevron or similar if in design, but logout usually doesn't have it.
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  void _showWorkspaceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Choose your workspace',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade100), borderRadius: BorderRadius.circular(8))),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildWorkspaceItem('Studio owner', IconConstants.store, false),
            const SizedBox(height: 12),
            _buildWorkspaceItem('Student', IconConstants.user, true),
            const SizedBox(height: 12),
            _buildWorkspaceItem('Teacher', IconConstants.graduate, false),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspaceItem(String title, String iconPath, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(.02) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.grey.withOpacity(.05) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              iconPath,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check,
              color: Colors.blue,
              size: 20,
            ),
        ],
      ),
    );
  }
}
