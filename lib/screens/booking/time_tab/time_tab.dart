import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/providers/providers.dart';
import 'package:fl_booking_app/screens/booking/time_tab/components/time_variant_builder.dart';
import 'package:fl_booking_app/screens/booking/booking_bottom_sheet.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key, required this.onNext, required this.onPrev});
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  State<TimeTab> createState() => _TimeTabExampleState();
}

class _TimeTabExampleState extends State<TimeTab>
    with AutomaticKeepAliveClientMixin<TimeTab> {
  late ValueNotifier<List<BookingVariant>> _selectedEvents;
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
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
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
    //print(futureBookingVariants);
  }

  List<BookingVariant> _getEventsForDay(DateTime day) {
    if (futureBookingVariants.isNotEmpty) {
      //print('notempty');
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
        color: const Color.fromARGB(255, 255, 221, 182),
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FilledButton(
                onPressed: () => {
                  widget.onPrev(),
                },
                style: FilledButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    minimumSize: const Size(80, 48)),
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
                  return FilledButton(
                    onPressed:
                        bookingInfo.bTime.isEmpty || bookingInfo.bDate.isEmpty
                            ? null
                            : widget.onNext,
                    style: FilledButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        minimumSize: const Size(80, 48)),
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
      body: Container(
        color: Colors.white,
        child: SizedBox(
          height: screenheight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SafeArea(
                          child: Column(children: [
                            FutureBuilder<List<OfficeDate>>(
                              future: futureOfficeDatesList,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  //print('snapshot');
                                  Provider.of<OfficeList>(context,
                                          listen: false)
                                      .calcOfficeDates(snapshot.data!);
                                  _selectedEvents.value =
                                      _getEventsForDay(_selectedDay!);
                                  //print(jsonTags);
                                  return Column(
                                    children: [
                                      Container(
                                        height: screenheight * 0.3,
                                        width: screenwidth,
                                        color: Colors.white,
                                        child: TableCalendar<BookingVariant>(
                                          firstDay: DateTime.parse(
                                              Provider.of<OfficeList>(context,
                                                      listen: false)
                                                  .officeDates
                                                  .first),
                                          lastDay: DateTime.parse(
                                              Provider.of<OfficeList>(context,
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
                                            return Provider.of<OfficeList>(
                                                    context,
                                                    listen: false)
                                                .officeDates
                                                .contains(
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(day));
                                          },
                                          onDaySelected: _onDaySelected,
                                          onPageChanged: (focusedDay) {
                                            _focusedDay = focusedDay;
                                          },
                                          startingDayOfWeek:
                                              StartingDayOfWeek.monday,
                                          eventLoader: _getEventsForDay,
                                        ),
                                      ),
                                      Container(
                                        height: 168,
                                        child: ValueListenableBuilder<
                                            List<BookingVariant>>(
                                          valueListenable: _selectedEvents,
                                          builder: (context, value, _) {
                                            //print(_selectedEvents);
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
                    ),
                  ],
                ),
                ServicesBottomSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
