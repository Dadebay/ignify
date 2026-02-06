import 'package:flutter/material.dart';
import '../models/calendar_event_model.dart';

class MonthCalendarGrid extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime displayMonth;
  final List<CalendarEvent> events;
  final Function(DateTime) onDateSelected;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthCalendarGrid({
    super.key,
    required this.selectedDate,
    required this.displayMonth,
    required this.events,
    required this.onDateSelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(displayMonth.year, displayMonth.month, 1);
    final lastDayOfMonth = DateTime(displayMonth.year, displayMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = Monday, adjust to 0 = Sunday
    final daysInMonth = lastDayOfMonth.day;

    // Calculate previous month days to show
    final previousMonth = DateTime(displayMonth.year, displayMonth.month - 1, 1);
    final daysInPreviousMonth = DateTime(displayMonth.year, displayMonth.month, 0).day;

    return Column(
      children: [
        // Month Header with Navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavButton(Icons.chevron_left, onPreviousMonth),
              Text(
                '${_getMonthName(displayMonth.month)} ${displayMonth.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              _buildNavButton(Icons.chevron_right, onNextMonth),
            ],
          ),
        ),
        // Weekday Headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        // Calendar Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8,
            ),
            itemCount: 42, // 6 weeks
            itemBuilder: (context, index) {
              final dayOffset = index - firstWeekday;
              DateTime date;
              bool isCurrentMonth = true;

              if (dayOffset < 0) {
                // Previous month
                date = DateTime(previousMonth.year, previousMonth.month, daysInPreviousMonth + dayOffset + 1);
                isCurrentMonth = false;
              } else if (dayOffset >= daysInMonth) {
                // Next month
                date = DateTime(displayMonth.year, displayMonth.month + 1, dayOffset - daysInMonth + 1);
                isCurrentMonth = false;
              } else {
                // Current month
                date = DateTime(displayMonth.year, displayMonth.month, dayOffset + 1);
              }

              final isSelected = selectedDate.year == date.year && selectedDate.month == date.month && selectedDate.day == date.day;

              // Find events for this date to determine dot colors
              final dayEvents = events.where((event) => event.isOnDate(date)).toList();

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2196F3) // Blue circle for selected
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                        12), // Rounded rect or circle? Design looks like rounded rect/circle hybrid or circle. Let's use rounded rect for now to match design. actually design is circle.
                    // shape: BoxShape.circle, // Design shows rounded rect for selected? No, blue circle.
                    shape: BoxShape.rectangle,
                    // The borderRadius is applied twice, once here and once in the inner container.
                    // The inner container's decoration will override the color of this outer one.
                    // Keeping it as per instruction.
                    // borderRadius: BorderRadius.circular(12),
                  ),
                  // Design check: Selected date is Blue Rounded Rectangle (almost circle but squarish).
                  // Let's stick to standard ShapeDecoration if we want circle, or BorderRadius for rounded rect.
                  // The image shows what looks like a Rounded Rectangle with high radius, basically a squaricle.

                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4285F4) : Colors.transparent, // Google Blue
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : isCurrentMonth
                                    ? Colors.black87
                                    : Colors.grey.shade400,
                          ),
                        ),
                        if (dayEvents.isNotEmpty && isCurrentMonth)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: dayEvents.take(3).map((event) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                  width: 5, // Slightly larger dots
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: event.personColor, // Use event person color
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
                ),
              );
            },
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
}
