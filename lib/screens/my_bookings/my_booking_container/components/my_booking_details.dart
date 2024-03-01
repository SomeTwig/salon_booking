import 'package:flutter/material.dart';

class MyBookingDetails extends StatefulWidget {
  final List<String> mockBookingDetails;

  const MyBookingDetails({super.key, required this.mockBookingDetails});
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
                  Icon(Icons.calendar_today),
                  SizedBox(
                    width: 8,
                  ),
                  Text(widget.mockBookingDetails[0]),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 8,
                  ),
                  Text(widget.mockBookingDetails[1]),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 8,
                  ),
                  Text(widget.mockBookingDetails[2]),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.phone_android),
                  SizedBox(
                    width: 8,
                  ),
                  Text(widget.mockBookingDetails[3]),
                ],
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
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
                      icon: Icon(Icons.location_on),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          backgroundColor: Color.fromARGB(255, 111, 247, 246),
                          fixedSize: Size(48, 48)),
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
                          backgroundColor: Color.fromARGB(255, 111, 247, 246),
                          fixedSize: Size(48, 48)),
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
