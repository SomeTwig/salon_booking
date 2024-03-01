import 'package:flutter/material.dart';

import 'package:fl_booking_app/screens/my_bookings/my_booking_container/components/all_components.dart';

class BookingContainer extends StatefulWidget {
  final List<String> mockBooking;

  const BookingContainer({super.key, required this.mockBooking});

  @override
  State<BookingContainer> createState() => _BookingContainerState();
}

class _BookingContainerState extends State<BookingContainer> {
  Widget sum(List<String> mockBookingDetails) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total'),
            Text(mockBookingDetails[4]),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 96,
                      height: 16,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 8,
                    child: Container(
                      width: 96,
                      height: 32,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 111, 247, 246),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Center(
                        child: Text('Tomorrow'),
                      ),
                    ),
                  ),
                ],
              ),
              MyBookingDetails(mockBookingDetails: widget.mockBooking),
              MyServicesList(),
              sum(widget.mockBooking),
              if (widget.mockBooking[5] == 'confirmed')
                // ! future booking - editing availible
                ConfirmedButtons(),
              if (widget.mockBooking[5] == 'finished')
                // ! past booking - repeat of services, comment, rating availible
                FinishedButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
