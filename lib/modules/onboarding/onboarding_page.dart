import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makc/core/theme/app_colors.dart';
import 'package:makc/modules/account/views/create_account_page.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String asset;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.asset,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      title: 'Discover Places Near You',
      subtitle: 'Find and filter through a variety of local places for your family’s activities',
      asset: 'assets/images/onboarding/onboard_1.png',
    ),
    OnboardingItem(
      title: 'All your schedules, One unified calendar',
      subtitle: 'Manage your personal and family schedules in a single view',
      asset: 'assets/images/onboarding/onboard_2.png',
    ),
    OnboardingItem(
      title: 'Connect Instantly With Places',
      subtitle: 'Stay in touch, ask questions, and cordinate with ease, all within the app.',
      asset: 'assets/images/onboarding/onboard_3.png',
    ),
  ];

  void _skip() {
    Get.offAll(() => const CreateAccountPage());
  }

  void _next() {
    if (_currentIndex == _items.length - 1) {
      _skip();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _skip,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            item.asset,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30, top: 10),
                          child: Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              child: _CircularProgressButton(
                progress: (_currentIndex + 1) / _items.length,
                onNext: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularProgressButton extends StatelessWidget {
  final double progress;
  final VoidCallback onNext;

  const _CircularProgressButton({required this.progress, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, _) {
              return CustomPaint(
                size: const Size(120, 120),
                painter: _RingPainter(value),
              );
            },
          ),
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimaryColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
                elevation: 0,
              ),
              child: const Icon(Icons.double_arrow_rounded, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;

  _RingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 3.0;
    final rect = Offset.zero & size;
    final startAngle = -90 * 3.1415926535 / 180; // start at top
    final sweep = 2 * 3.1415926535 * progress;

    final basePaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw full circle background
    canvas.drawArc(rect.deflate(strokeWidth / 2 + 4), 0, 2 * 3.1415926535, false, basePaint);
    // Draw progress arc starting from top
    canvas.drawArc(rect.deflate(strokeWidth / 2 + 4), startAngle, sweep, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.progress != progress;
}
