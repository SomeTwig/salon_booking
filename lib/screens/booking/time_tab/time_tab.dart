import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/providers/providers.dart';
import 'package:fl_booking_app/screens/booking/time_tab/components/time_variant_builder.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key, required this.onNext, required this.onPrev});
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  State<TimeTab> createState() => _TimeTabExampleState();
}

class _TimeTabExampleState extends State<TimeTab>
    with AutomaticKeepAliveClientMixin<TimeTab> {
  late final ValueNotifier<List<BookingVariant>> _selectedEvents;
  late Future<List<OfficeDate>> futureOfficeDatesList;
  late List<BookingVariant> futureBookingVariants = [];

  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime kToday = DateTime.now();
  final int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureOfficeDatesList = OfficeList().fetchAllOfficeDates();
    _selectedDay = _focusedDay;
    addFutBookVar();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void addFutBookVar() async {
    String cdate = DateFormat("yyyy-MM-dd").format(_focusedDay);
    //print(cdate);
    String jsonTags =
        jsonEncode(Provider.of<BookingInfo>(context, listen: false).services);
    futureBookingVariants = await BookingInfo().fetchBookingVariants(
        Provider.of<OfficeList>(context, listen: false).office.officeId,
        cdate,
        jsonTags);
    print(futureBookingVariants);
  }

  List<BookingVariant> _getEventsForDay(DateTime day) {
    if (futureBookingVariants.isNotEmpty) {
      print('notempty');
      return futureBookingVariants;
    }
    return [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      String cdate = DateFormat("yyyy-MM-dd").format(selectedDay);
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        Provider.of<BookingInfo>(context, listen: false).addDate(cdate);
      });
      String jsonTags =
          jsonEncode(Provider.of<BookingInfo>(context, listen: false).services);
      futureBookingVariants = await BookingInfo().fetchBookingVariants(
          Provider.of<OfficeList>(context, listen: false).office.officeId,
          cdate,
          jsonTags);
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(157, 192, 158, 120),
        height: screenheight * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                onPressed: () => {
                  widget.onPrev(),
                },
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    minimumSize: const Size(100, 40)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Назад'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      // <-- Icon
                      Icons.arrow_back_ios_rounded,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Consumer<BookingInfo>(
                builder: (context, bookingInfo, _) {
                  return ElevatedButton(
                    onPressed:
                        bookingInfo.bTime.isEmpty || bookingInfo.bDate.isEmpty
                            ? null
                            : widget.onNext,
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        minimumSize: const Size(100, 40)),
                    child: const Row(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(children: [
                Container(
                  width: screenwidth,
                  height: screenheight * 0.1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Выбраный салон: \n${Provider.of<BookingInfo>(context, listen: false).sName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                FutureBuilder<List<OfficeDate>>(
                  future: futureOfficeDatesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print('snapshot');
                      print(snapshot.data);
                      Provider.of<OfficeList>(context, listen: false)
                          .calcOfficeDates(snapshot.data!);
                      //print(jsonTags);
                      return Column(
                        children: [
                          Container(
                            height: screenheight * 0.3,
                            width: screenwidth,
                            color: Colors.white,
                            child: TableCalendar<BookingVariant>(
                              firstDay: DateTime.parse(Provider.of<OfficeList>(
                                      context,
                                      listen: false)
                                  .officeDates
                                  .first),
                              lastDay: DateTime.parse(Provider.of<OfficeList>(
                                      context,
                                      listen: false)
                                  .officeDates
                                  .last),
                              focusedDay: DateTime.parse(
                                  Provider.of<OfficeList>(context,
                                          listen: false)
                                      .officeDates
                                      .first),
                              locale: 'ru_RU',
                              calendarFormat: _calendarFormat,
                              availableCalendarFormats: const {
                                CalendarFormat.twoWeeks: '2 Недели',
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              enabledDayPredicate: (day) {
                                //
                                return Provider.of<OfficeList>(context,
                                        listen: false)
                                    .officeDates
                                    .contains(
                                        DateFormat("yyyy-MM-dd").format(day));
                              },
                              onDaySelected: _onDaySelected,
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              eventLoader: _getEventsForDay,
                            ),
                          ),
                          Container(
                            height: screenheight * 0.4,
                            color: Colors.white,
                            padding:
                                EdgeInsets.only(bottom: screenheight * 0.1),
                            child: ValueListenableBuilder<List<BookingVariant>>(
                              valueListenable: _selectedEvents,
                              builder: (context, value, _) {
                                return TimeVariantBuilder(
                                    bookingVarList: value);
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
