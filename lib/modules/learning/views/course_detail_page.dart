import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../models/course_content_model.dart';
import '../widgets/video_list_item.dart';
import '../widgets/document_list_item.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data
    final videos = [
      VideoItem(
        id: '1',
        title: '01. Tool Basics',
        duration: '12:45',
        format: 'MP4',
        isCompleted: true,
      ),
      VideoItem(
        id: '2',
        title: '02. Advanced layers',
        duration: '13:45',
        format: 'MP4',
        isCompleted: false,
      ),
    ];

    final documents = [
      DocumentItem(
        id: '1',
        title: 'Course Syllabus',
        size: '2.4 MB',
        format: 'PDF',
        isCompleted: true,
      ),
      DocumentItem(
        id: '2',
        title: 'Practice Videos',
        size: '12:45',
        format: 'MP4',
        isCompleted: false,
      ),
    ];

    final completedVideos = videos.where((v) => v.isCompleted).length;
    final progressPercentage = ((completedVideos / videos.length) * 100).round();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: // Custom back button
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50], // Very light grey background
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Course detail',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold, // Bold title
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24), // Rounded corners
                child: Image.asset(
                  course.imageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Course Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                course.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Practice Videos Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Practice Videos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '$progressPercentage% Done',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2196F3),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Video List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: videos.map((video) {
                  return VideoListItem(
                    video: video,
                    onCompletedChanged: (value) {
                      // Handle completion toggle
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Documents Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Documents',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Document List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: documents.map((document) {
                  return DocumentListItem(
                    document: document,
                    onCompletedChanged: (value) {
                      // Handle completion toggle
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
