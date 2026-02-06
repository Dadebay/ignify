import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:makc/core/theme/app_colors.dart';
import 'package:makc/data/controller/connection_controller.dart';
import 'package:makc/modules/account/views/create_account_page.dart';
import 'package:makc/modules/onboarding/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _connectionController = Get.find<ConnectionController>();
  final _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _startFlow();
  }

  Future<void> _startFlow() async {
    await _connectionController.checkInitialConnection();
    if (!_connectionController.hasConnection.value) {
      await _showNoConnectionDialog();
      return;
    }

    // Small pause to let the splash feel intentional.
    await Future.delayed(const Duration(milliseconds: 700));

    final hasSeenOnboarding = _storage.read('hasSeenOnboarding') == true;
    if (!hasSeenOnboarding) {
      _storage.write('hasSeenOnboarding', true);
      Get.offAll(() => const OnboardingPage());
    } else {
      Get.offAll(() => const CreateAccountPage());
    }
  }

  Future<void> _showNoConnectionDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('No internet connection'),
          content: const Text('Please check your connection and try again.'),
          actions: [
            TextButton(
              onPressed: () async {
                await _connectionController.checkInitialConnection();
                if (_connectionController.hasConnection.value) {
                  Navigator.of(ctx).pop();
                  _startFlow();
                }
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/onboarding/IGNIFY.png',
                width: 120,
                height: 120,
              ),
            ),
            LinearProgressIndicator(
              color: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
