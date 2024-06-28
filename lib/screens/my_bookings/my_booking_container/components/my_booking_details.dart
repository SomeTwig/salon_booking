import 'package:flutter/material.dart';

import 'package:fl_booking_app/data/booking_data.dart';

class MyBookingDetails extends StatefulWidget {

  final BookingData myBooking;

  const MyBookingDetails(
      {super.key, required this.myBooking});
  @override
  State<MyBookingDetails> createState() => _MyBookingDetailsState();
}

class _MyBookingDetailsState extends State<MyBookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(widget.myBooking.date),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(widget.myBooking.time),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                      width: 164,
                      child: Text(
                        widget.myBooking.salonName,
                        softWrap: true,
                      )),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.phone_android),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Salon phone number'),
                ],
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          clipBehavior: Clip.none,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 64,
                height: 128,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 76,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 106, 106),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          backgroundColor: const Color.fromARGB(255, 111, 247, 246),
                          fixedSize: const Size(48, 48)),
                    )),
              ),
            ),
            Positioned(
              left: 0,
              top: 64,
              child: Container(
                width: 76,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 106, 106),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {},
                      icon: Transform.flip(
                        flipX: true,
                        child: const Icon(Icons.call),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          backgroundColor: const Color.fromARGB(255, 111, 247, 246),
                          fixedSize: const Size(48, 48)),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
