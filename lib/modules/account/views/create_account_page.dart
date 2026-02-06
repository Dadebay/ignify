import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:makc/core/constants/icon_constants.dart';
import 'package:makc/core/theme/app_colors.dart';
import 'package:makc/modules/account/views/kids_pair_page.dart';
import 'package:makc/modules/account/views/login_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String _selected = 'student';

  void _onContinue() {
    if (_selected.isEmpty) {
      return;
    }
    if (_selected == 'student') {
      Get.to(() => const KidsPairPage());
    } else {
      Get.to(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Center(
                    child: Text(
                      'Select an account type',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Center(
                      child: Text(
                        'This will help us set up your account correctly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  _AccountCard(
                    label: 'Student',
                    value: 'student',
                    icon: IconConstants.user,
                    selected: _selected == 'student',
                    onTap: () => setState(() => _selected = 'student'),
                  ),
                  SizedBox(height: 20),
                  _AccountCard(
                    label: 'Teacher',
                    value: 'teacher',
                    icon: IconConstants.userCircle,
                    selected: _selected == 'teacher',
                    onTap: () => setState(() => _selected = 'teacher'),
                  ),
                  SizedBox(height: 20),
                  _AccountCard(
                    label: 'Business owner',
                    value: 'business',
                    icon: IconConstants.school,
                    selected: _selected == 'business',
                    onTap: () => setState(() => _selected = 'business'),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  const _AccountCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.kPrimaryColor : Colors.grey.shade300,
            width: selected ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 22, height: 22, color: Colors.grey[800]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.kPrimaryColor : Colors.grey.shade400,
                  width: 1.4,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
