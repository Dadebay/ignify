enum StudioStatus {
  open,
  closed,
  comingSoon,
}

class Studio {
  final String id;
  final String name;
  final String type;
  final String logoUrl;
  final StudioStatus status;
  final double? rating;
  final double? distanceMiles;

  Studio({
    required this.id,
    required this.name,
    required this.type,
    required this.logoUrl,
    required this.status,
    this.rating,
    this.distanceMiles,
  });

  String get statusText {
    switch (status) {
      case StudioStatus.open:
        return 'Open';
      case StudioStatus.closed:
        return 'Closed';
      case StudioStatus.comingSoon:
        return 'Classes soon';
    }
  }

  String? get distanceText {
    if (distanceMiles == null) return null;
    return '${distanceMiles!.toStringAsFixed(2)} mi';
  }
}
