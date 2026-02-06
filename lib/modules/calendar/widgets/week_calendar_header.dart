import 'package:flutter/material.dart';
import '../models/calendar_event_model.dart';

class WeekCalendarHeader extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime weekStart;
  final List<CalendarEvent> events;
  final Function(DateTime) onDateSelected;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const WeekCalendarHeader({
    super.key,
    required this.selectedDate,
    required this.weekStart,
    required this.events,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month/Year Header with Navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavButton(Icons.chevron_left, onPreviousWeek),
              Text(
                '${_getMonthName(weekStart.month)} ${weekStart.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              _buildNavButton(Icons.chevron_right, onNextWeek),
            ],
          ),
        ),
        // Week Days
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final date = weekStart.add(Duration(days: index));
              final isSelected = selectedDate.year == date.year && selectedDate.month == date.month && selectedDate.day == date.day;

              // Find events for this date
              final dayEvents = events.where((event) => event.isOnDate(date)).toList();

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  width: 48,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Text(
                        _getWeekdayName(date.weekday),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 44,
                        height: 52, // Taller for week view selection based on design
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF4285F4) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            if (dayEvents.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: dayEvents.take(3).map((event) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: event.personColor,
                                        shape: BoxShape.circle,
                                        border: isSelected ? Border.all(color: Colors.white, width: 1) : null,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: Colors.black87),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return weekdays[(weekday - 1) % 7];
  }
}
