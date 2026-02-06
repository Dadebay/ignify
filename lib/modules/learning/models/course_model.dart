class Course {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final int lessonNumber;
  final int totalLessons;
  final int progressPercentage;
  final String? recommendation;

  Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.lessonNumber,
    required this.totalLessons,
    required this.progressPercentage,
    this.recommendation,
  });

  double get progress => progressPercentage / 100.0;

  String get lessonProgress => 'Lesson $lessonNumber of $totalLessons';

  String get progressText => '$progressPercentage% completed';
}
