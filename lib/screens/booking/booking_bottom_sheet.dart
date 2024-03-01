import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/services_add.dart';
import 'package:fl_booking_app/screens/booking/services_tab/components/service_container.dart';

class ServicesBottomSheet extends StatefulWidget {
  const ServicesBottomSheet({super.key});

  @override
  State<ServicesBottomSheet> createState() => _ServicesBottomSheetState();
}

class _ServicesBottomSheetState extends State<ServicesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.12,
      maxChildSize: 0.5,
      minChildSize: 0.12,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 221, 182),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: ListView(
                controller: scrollController,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    title: Text(
                      'Сумма',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    trailing: Consumer<BookingInfo>(
                      builder: (context, serviceList, _) {
                        return Text(
                          '${serviceList.priceTotal} грн',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Salon',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 168,
                      child: Text(
                        Provider.of<BookingInfo>(context, listen: false).sName,
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Date & Time',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 168,
                      child: Text(
                        '${Provider.of<BookingInfo>(context, listen: false).bDate} \n${Provider.of<BookingInfo>(context, listen: false).bTime}',
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IgnorePointer(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height: 4,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 157, 80, 55),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
