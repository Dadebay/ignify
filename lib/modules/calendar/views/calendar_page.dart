import 'package:flutter/material.dart';
import 'package:makc/core/constants/icon_constants.dart';
import '../models/calendar_event_model.dart';
import '../models/calendar_view_mode.dart';
import '../widgets/person_filter_chip.dart';
import '../widgets/calendar_event_card.dart';
import '../widgets/tip_card.dart';
import '../widgets/month_calendar_grid.dart';
import '../widgets/week_calendar_header.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarViewMode _viewMode = CalendarViewMode.month;
  String _selectedPerson = 'All';
  DateTime _selectedDate = DateTime.now();
  DateTime _displayMonth = DateTime.now();

  // Mock data
  late final List<CalendarEvent> _allEvents;

  @override
  void initState() {
    super.initState();
    _allEvents = [
      CalendarEvent(
        id: '1',
        title: 'LEGO Robotics I (Ages 7-10)',
        startTime: DateTime(2025, 9, 4, 10, 0),
        endTime: DateTime(2025, 9, 4, 11, 0),
        location: 'The STEM Lab Robotics & Coding',
        imageUrl: 'assets/images/featured_1.png',
        personName: 'Nathan',
        personColor: const Color(0xFFE91E63),
        hasReports: true,
      ),
      CalendarEvent(
        id: '2',
        title: 'Young DaVinci\'s Drawing',
        startTime: DateTime(2025, 9, 4, 10, 0),
        endTime: DateTime(2025, 9, 4, 11, 0),
        location: 'The Creative Canvas Art School',
        imageUrl: 'assets/images/featured_2.png',
        personName: 'Alex',
        personColor: const Color(0xFF4CAF50),
        hasReports: true,
      ),
      CalendarEvent(
        id: '3',
        title: 'LEGO Robotics I (Ages 7-10)',
        startTime: DateTime(2025, 9, 21, 10, 0),
        endTime: DateTime(2025, 9, 21, 11, 0),
        location: 'The STEM Lab Robotics & Coding',
        imageUrl: 'assets/images/featured_1.png',
        personName: 'Nathan',
        personColor: const Color(0xFFE91E63),
        isLive: true,
      ),
      CalendarEvent(
        id: '4',
        title: 'Young DaVinci\'s Drawing',
        startTime: DateTime(2025, 9, 21, 10, 0),
        endTime: DateTime(2025, 9, 21, 11, 0),
        location: 'The Creative Canvas Art School',
        imageUrl: 'assets/images/featured_2.png',
        personName: 'Alex',
        personColor: const Color(0xFF4CAF50),
      ),
    ];
  }

  List<CalendarEvent> get _filteredEvents {
    if (_selectedPerson == 'All') {
      return _allEvents;
    }
    return _allEvents.where((event) => event.personName == _selectedPerson).toList();
  }

  List<CalendarEvent> get _selectedDateEvents {
    return _filteredEvents.where((event) => event.isOnDate(_selectedDate)).toList();
  }

  DateTime get _weekStart {
    final weekday = _selectedDate.weekday;
    return _selectedDate.subtract(Duration(days: weekday - 1));
  }

  void _changeMonth(int delta) {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + delta);
    });
  }

  void _changeWeek(int delta) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 7 * delta));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Calendar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Person Filters
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  PersonFilterChip(
                    label: 'All',
                    iconPath: IconConstants.users,
                    color: const Color(0xFF2196F3),
                    isSelected: _selectedPerson == 'All',
                    onTap: () => setState(() => _selectedPerson = 'All'),
                  ),
                  const SizedBox(width: 8),
                  PersonFilterChip(
                    label: 'Nathan',
                    iconPath: IconConstants.user,
                    color: const Color(0xFFE91E63),
                    isSelected: _selectedPerson == 'Nathan',
                    onTap: () => setState(() => _selectedPerson = 'Nathan'),
                  ),
                  const SizedBox(width: 8),
                  PersonFilterChip(
                    label: 'Alex',
                    iconPath: IconConstants.user,
                    color: const Color(0xFF4CAF50),
                    isSelected: _selectedPerson == 'Alex',
                    onTap: () => setState(() => _selectedPerson = 'Alex'),
                  ),
                  const SizedBox(width: 8),
                  PersonFilterChip(
                    label: 'Max',
                    iconPath: IconConstants.user,
                    color: const Color(0xFFFFC107),
                    isSelected: _selectedPerson == 'Max',
                    onTap: () => setState(() => _selectedPerson = 'Max'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // View Mode Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildViewModeSelector(),
            ),
            const SizedBox(height: 16),
            // Content based on view mode
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_viewMode == CalendarViewMode.month) ...[
                      MonthCalendarGrid(
                        selectedDate: _selectedDate,
                        displayMonth: _displayMonth,
                        events: _filteredEvents,
                        onDateSelected: (date) => setState(() => _selectedDate = date),
                        onPreviousMonth: () => _changeMonth(-1),
                        onNextMonth: () => _changeMonth(1),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          _getFormattedDate(_selectedDate, showYear: false),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ] else if (_viewMode == CalendarViewMode.week) ...[
                      WeekCalendarHeader(
                        selectedDate: _selectedDate,
                        weekStart: _weekStart,
                        events: _filteredEvents,
                        onDateSelected: (date) => setState(() => _selectedDate = date),
                        onPreviousWeek: () => _changeWeek(-1),
                        onNextWeek: () => _changeWeek(1),
                      ),
                      const TipCard(
                        message: 'Your next productive learning time is 2-4 PM. Consider scheduling challenging courses during this window.',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          _getFormattedDate(_selectedDate, showYear: false),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ] else ...[
                      // Day view
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () => setState(() {
                                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                              }),
                            ),
                            Text(
                              _getFormattedDate(_selectedDate),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () => setState(() {
                                _selectedDate = _selectedDate.add(const Duration(days: 1));
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    // Event List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _selectedDateEvents.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: Text(
                                  'No events scheduled',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: _selectedDateEvents.map((event) => CalendarEventCard(event: event)).toList(),
                            ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewModeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildViewModeItem('Month', CalendarViewMode.month),
          _buildViewModeItem('Week', CalendarViewMode.week),
          _buildViewModeItem('Day', CalendarViewMode.day),
        ],
      ),
    );
  }

  Widget _buildViewModeItem(String label, CalendarViewMode mode) {
    final isSelected = _viewMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _viewMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  String _getFormattedDate(DateTime date, {bool showYear = true}) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    final weekday = weekdays[(date.weekday - 1) % 7];
    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;

    if (showYear) {
      return '$weekday, $month $day, $year';
    } else {
      return '$weekday, $month $day';
    }
  }
}
