import 'package:flutter/material.dart';

import 'package:fl_booking_app/screens/my_bookings/my_booking_container/components/all_components.dart';
import 'package:fl_booking_app/data/booking_data.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/data/db_helper.dart';

class BookingContainer extends StatefulWidget {
  final BookingData myBooking;

  const BookingContainer(
      {super.key, required this.myBooking});

  @override
  State<BookingContainer> createState() => _BookingContainerState();
}

class _BookingContainerState extends State<BookingContainer> {
  late Future<List<FLService>> futureMyBookingServicesList;

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();

    dbHelper = DatabaseHelper();
    dbHelper.initDatabase();
    futureMyBookingServicesList = dbHelper.getOneBookingServices(
        widget.myBooking.date,
        widget.myBooking.time,
        widget.myBooking.clientPhone,
        widget.myBooking.salonId.toString());
  }

  Widget sum(BookingData myBookingData) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total'),
            Text(myBookingData.priceTotal.toString()),
          ],
        ),
      ),
    );
  }

  Widget actionIconButtons = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
        heroTag: "phoneBtn",
        onPressed: () {},
        child: const Icon(Icons.phone),
      ),
      const SizedBox(
        height: 16,
      ),
      FloatingActionButton(
        heroTag: "navBtn",
        onPressed: () {},
        child: const Icon(Icons.navigation),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                clipBehavior: Clip.none,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 96,
                      height: 16,
                    ),
                  ),
                  Container(child: () {
                    if (DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day + 1) ==
                        DateTime.parse(widget.myBooking.date)) {
                      return Positioned(
                        left: 16,
                        bottom: 8,
                        child: Container(
                          width: 96,
                          height: 32,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 111, 247, 246),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: const Center(
                            child: Text('Tomorrow'),
                          ),
                        ),
                      );
                    }
                  }()),
                ],
              ),
              MyBookingDetails(
                  myBooking: widget.myBooking),
              FutureBuilder<List<FLService>>(
                  future: futureMyBookingServicesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MyServicesList(myBookingServices: snapshot.data!);
                    } else if (snapshot.hasData == false) {
                      return const Text('You haven`t booked any services.');
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }),
              
              sum(widget.myBooking),
              if (DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)
                  .isBefore(DateTime.parse(widget.myBooking.date)))
                // ! future booking - editing availible
                ConfirmedButtons(myBooking: widget.myBooking),
              if (DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)
                  .isAfter(DateTime.parse(widget.myBooking.date)))
                // ! past booking - repeat of services, comment, rating availible
                const FinishedButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
