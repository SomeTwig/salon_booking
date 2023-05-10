import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:test_1/models/models.dart';

import 'package:test_1/data/data.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<TimeTab> createState() => _TimeTabExampleState();
}

class _TimeTabExampleState extends State<TimeTab>
    with AutomaticKeepAliveClientMixin<TimeTab> {
  late final ValueNotifier<List<String>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime kToday = DateTime.now();
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    Provider.of<BookingInfo>(context, listen: false).addDateTime(
        DateFormat("yyyy-MM-dd").format(_selectedDay!),
        _selectedEvents.value[_selectedIndex]);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<String> _getEventsForDay(DateTime day) {
    // Implementation example
    String cdate = DateFormat("yyyy-MM-dd").format(day);

    for (final item in datetimes) {
      if (item.date == cdate) {
        return item.times;
      }
    }
    return [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
      print(_selectedEvents.value.isEmpty);
      if (_selectedEvents.value.isEmpty == false) {
        Provider.of<BookingInfo>(context, listen: false).addDateTime(
            DateFormat("yyyy-MM-dd").format(_selectedDay!),
            _selectedEvents.value[_selectedIndex]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: 70,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {
                  if (_selectedEvents.value.isNotEmpty == true)
                    {
                      Provider.of<BookingInfo>(context, listen: false)
                          .addDateTime(
                              DateFormat("yyyy-MM-dd").format(_selectedDay!),
                              _selectedEvents.value[_selectedIndex]),
                    },
                  widget.onNext(),
                },
                style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    minimumSize: Size(100, 50)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Далее'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      // <-- Icon
                      Icons.arrow_forward_ios_rounded,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(children: [
          Text(
            'Выбраный салон: \n${Provider.of<BookingInfo>(context, listen: false).sName}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          TableCalendar<String>(
            firstDay: kToday,
            lastDay: DateTime(kToday.year, kToday.month + 3, kToday.day),
            focusedDay: _focusedDay,
            locale: 'ru_RU',
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            availableCalendarFormats: const {
              CalendarFormat.twoWeeks: '2 Недели',
              CalendarFormat.week: 'Неделя',
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Color.fromARGB(255, 131, 144, 172)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(value[index]),
                        selectedColor: Color.fromARGB(255, 7, 4, 4),
                        selectedTileColor: Color.fromARGB(255, 198, 205, 220),
                        selected: index == _selectedIndex,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });

                          Provider.of<BookingInfo>(context, listen: false)
                              .addDateTime(
                                  DateFormat("yyyy-MM-dd")
                                      .format(_selectedDay!),
                                  _selectedEvents.value[_selectedIndex]);
                        },
                      ),
                    );
                    // TimeRangeListTile(
                    //   text: value[index],
                    //   index: index,
                    // );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
        ]));
  }
}
