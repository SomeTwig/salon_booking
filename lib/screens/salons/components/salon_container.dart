import 'package:flutter/material.dart';
import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/providers/providers.dart';

import 'package:provider/provider.dart';

import '../../../routes/route.dart' as route;

class SalonContainer extends StatefulWidget {
  final FLOffice flSalon;

  const SalonContainer({super.key, required this.flSalon});

  @override
  State<SalonContainer> createState() => _SalonContainerState();
}

class _SalonContainerState extends State<SalonContainer> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: size.width,
      height: size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.flSalon.officeName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.flSalon.officeAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: mySecondryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  color: myPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Provider.of<BookingInfo>(context, listen: false)
                        .addSalon(widget.flSalon.officeName, widget.flSalon.officeId);
                    Provider.of<OfficeList>(context, listen: false)
                        .addOffice(widget.flSalon);
                    Navigator.pushNamed(context, route.bookingPage);
                  },
                  child: const Text(
                    'Бронировать',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
