import 'package:flutter/material.dart';
import '../widgets/account_menu_item.dart';
import '../views/simple_page.dart';
import '../../../../core/constants/icon_constants.dart';

class GuestAccountView extends StatelessWidget {
  final VoidCallback onCreateAccount;
  final VoidCallback onLogin;

  const GuestAccountView({
    super.key,
    required this.onCreateAccount,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 40),
            child: Image.asset('assets/images/avatar.png', width: 100, height: 100),
          ),
          // Title
          const Text(
            'Guest Account',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Create a free account to book classes, save favourites, and track your progress.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Create Account Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onCreateAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Login Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account? ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: onLogin,
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          // General Section Header
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              'General',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          // Grouped Menu Items
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
