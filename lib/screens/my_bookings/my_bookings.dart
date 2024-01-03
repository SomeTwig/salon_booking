import 'package:flutter/material.dart';

import 'package:fl_booking_app/screens/my_bookings/components/my_booking_container.dart';

import 'package:fl_booking_app/data/data.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    List<List<String>> myMockBookings = [mockBooking1, mockBooking2];
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return BookingContainer(mockBooking: myMockBookings.elementAt(index));
          },
        ),
      ),
    );
  }
}
