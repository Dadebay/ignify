class VideoItem {
  final String id;
  final String title;
  final String duration;
  final String format;
  final bool isCompleted;

  VideoItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.format,
    this.isCompleted = false,
  });

  String get durationFormat => '$duration . $format';
}

class DocumentItem {
  final String id;
  final String title;
  final String size;
  final String format;
  final bool isCompleted;

  DocumentItem({
    required this.id,
    required this.title,
    required this.size,
    required this.format,
    this.isCompleted = false,
  });

  String get sizeFormat => '$size . $format';
}
