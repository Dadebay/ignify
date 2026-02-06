import 'package:flutter/material.dart';

class CalendarEvent {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String imageUrl;
  final String personName;
  final Color personColor;
  final bool isLive;
  final bool hasReports;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.imageUrl,
    required this.personName,
    required this.personColor,
    this.isLive = false,
    this.hasReports = false,
  });

  String get timeRange {
    final startStr = '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    final endStr = '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$startStr - $endStr';
  }

  bool isOnDate(DateTime date) {
    return startTime.year == date.year && startTime.month == date.month && startTime.day == date.day;
  }
}
