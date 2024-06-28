import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_booking_app/screens/my_bookings/my_booking_container/my_booking_container.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/data/db_helper.dart';
import 'package:fl_booking_app/data/booking_data.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  late Future<List<BookingData>> futureMyBookingsList;

  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();

    dbHelper = DatabaseHelper();
    dbHelper.initDatabase();
    futureMyBookingsList = dbHelper.getAccountBookings(
        Provider.of<MyAccount>(context, listen: false).accountName,
        Provider.of<MyAccount>(context, listen: false).accountPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<BookingData>>(
            future: futureMyBookingsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookingContainer(
                      myBooking: snapshot.data!.elementAt(index),
                    );
                  },
                );
              } else if (snapshot.hasData == false) {
                return const Text('You haven`t made any appointments yet');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
