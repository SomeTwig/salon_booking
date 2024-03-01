import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/providers/providers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';


class SalonContainer extends StatefulWidget {
  final FLOffice flSalon;

  const SalonContainer({super.key, required this.flSalon});

  @override
  State<SalonContainer> createState() => _SalonContainerState();
}

class _SalonContainerState extends State<SalonContainer> {
  Widget actionIconButtons = Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
        heroTag: "phoneBtn",
        onPressed: () {},
        child: const Icon(Icons.phone),
      ),
      const SizedBox(
        width: 16,
      ),
      FloatingActionButton(
        heroTag: "navBtn",
        onPressed: () {},
        child: const Icon(Icons.navigation),
      ),
    ],
  );

  Text heading = const Text("Name");

  Widget subheading = const Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.location_on),
          SizedBox(
            width: 8,
          ),
          Text("Address"),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.phone_android),
          SizedBox(
            width: 8,
          ),
          Text("+280000000000"),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // salon card
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                clipBehavior: Clip.none,
                children: [
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        //clipped to fit the card
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          heightFactor: 0.5,
                          child: Image(
                              image:
                                  AssetImage('assets/images/salon_image.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 28,
                    child: Container(
                      width: 156,
                      height: 28,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(192, 255, 221, 182),
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(16))),
                      child: Center(
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                          ignoreGestures: true,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 0,
                    child: actionIconButtons,
                  ),
                ],
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: heading,
                ),
                subtitle: subheading,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_drop_down),
                      label: const Text("Comments"),
                    ),
                    FilledButton(
                      onPressed: () {
                        // Provider.of<BookingInfo>(context, listen: false)
                        //     .addSalon(widget.flSalon.officeName, widget.flSalon.officeId);
                        // Provider.of<OfficeList>(context, listen: false)
                        //     .addOffice(widget.flSalon);
                        Provider.of<BookingInfo>(context, listen: false)
                            .addSalon(widget.flSalon.officeName, widget.flSalon.officeId);
                        Provider.of<OfficeList>(context, listen: false)
                            .addOffice(widget.flSalon);
                        GoRouter.of(context).go('/home/booking');
                      },
                      child: const Text("Book"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
