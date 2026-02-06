import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makc/core/constants/icon_constants.dart';
import '../models/course_model.dart';
import '../models/studio_model.dart';
import '../widgets/course_card.dart';
import '../widgets/studio_card.dart';
import '../widgets/studio_card.dart';
import 'course_detail_page.dart';
import 'package:makc/modules/calendar/models/calendar_event_model.dart';
import 'package:makc/modules/calendar/views/calendar_event_detail_page.dart';

class LearningHubPage extends StatelessWidget {
  const LearningHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final courses = [
      Course(
        id: '1',
        title: 'Piano Explorers (Ages 5-7)',
        subtitle: 'Music Fundamentals',
        imageUrl: 'assets/images/piano_course.png',
        lessonNumber: 4,
        totalLessons: 12,
        progressPercentage: 65,
        recommendation: 'Based on your progress, you\'re ready to tackle "Advanced Improvisation Techniques". This course builds perfectly on your current skills.',
      ),
      Course(
        id: '2',
        title: 'Art History for Kids',
        subtitle: 'Visual Arts',
        imageUrl: 'assets/images/art_course.png',
        lessonNumber: 4,
        totalLessons: 12,
        progressPercentage: 65,
      ),
    ];

    final studios = [
      Studio(
        id: '1',
        name: 'Harmony House Music Lessons',
        type: 'Music Academy',
        logoUrl: 'assets/images/logo_5.png',
        status: StudioStatus.open,
        rating: 4.8,
        distanceMiles: 1.24,
      ),
      Studio(
        id: '2',
        name: 'The Creative . Canvas Art School',
        type: 'Art School . Overland Park, Kansas',
        logoUrl: 'assets/images/logo_4.png',
        status: StudioStatus.comingSoon,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Hub',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Continue your learning journey',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Course Cards
              SizedBox(
                height: 220,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(
                      course: courses[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(course: courses[index]),
                          ),
                        );
                      },
                    );
                  },
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
                          child: SvgPicture.asset(IconConstants.aiIcon, colorFilter: const ColorFilter.mode(Color(0xFF972AF7), BlendMode.srcIn)),
                        ),
                        Expanded(
                          child: const Text(
                            "Based on your progress, you're ready to tackle 'Advanced Improvisation Techniques'. This course builds perfectly on your current skills.",
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('View course', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),

              // My Studios Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My Studios',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Studio Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: studios.map((studio) {
                    return StudioCard(
                      studio: studio,
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return CalendarEventDetailPage(event: _studioToEvent(studio));
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  CalendarEvent _studioToEvent(Studio studio) {
    final start = DateTime.now();
    final end = start.add(const Duration(minutes: 90));
    return CalendarEvent(
      id: studio.id,
      title: studio.name,
      startTime: start,
      endTime: end,
      location: studio.type,
      imageUrl: 'assets/images/featured_1.png',
      personName: 'Studio',
      personColor: const Color(0xFF2196F3),
      hasReports: false,
    );
  }
}
