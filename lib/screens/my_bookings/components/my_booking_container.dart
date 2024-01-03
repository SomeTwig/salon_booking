import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookingContainer extends StatefulWidget {
  final List<String> mockBooking;

  const BookingContainer({super.key, required this.mockBooking});

  @override
  State<BookingContainer> createState() => _BookingContainerState();
}

class _BookingContainerState extends State<BookingContainer> {
  Widget bookingDetails(List<String> mockBookingDetails) {
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
                  Text(mockBookingDetails[0]),
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
                  Text(mockBookingDetails[1]),
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
                  Text(mockBookingDetails[2]),
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
                  Text(mockBookingDetails[3]),
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(16))),
                      child: Center(
                        child: Text('Tomorrow'),
                      ),
                    ),
                  ),
                ],
              ),
              bookingDetails(widget.mockBooking),
              MyServicesList(),
              sum(widget.mockBooking),
              // ! future booking - editing availible
              // TODO show different choices depending on the date and/or state of the booking
              // Container(
              //   padding: EdgeInsets.all(16),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: FilledButton(
              //       onPressed: () {},
              //       child: const Text('Edit booking'),
              //     ),
              //   ),
              // ),
              // ! past booking - repeat of services, comment, rating availible
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Repeat services'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Comment'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your rating:"),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25,
                      itemPadding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 185, 90),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyServicesList extends StatefulWidget {
  const MyServicesList({Key? key}) : super(key: key);

  @override
  _MyServicesListState createState() => _MyServicesListState();
}

class _MyServicesListState extends State<MyServicesList> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Services'),
      trailing: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 221, 182),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Icon(
          size: 24,
          _customTileExpanded
              ? Icons.arrow_drop_up_outlined
              : Icons.arrow_drop_down_outlined,
        ),
      ),
      children: // change to ListView.Builder for real data
          const <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service name'),
                  Text('123.00 USD'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('Service name'),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('123.00 USD',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('-12%'),
                        ],
                      ),
                    ],
                  ),
                  Text('123.00 USD'),
                ],
              ),
            ),
          ],
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
}
