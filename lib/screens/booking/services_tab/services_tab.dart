//one of the booking tabs, includes services already chosen by the customer
//and button to add new services (->services_add)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/services_add.dart';
import 'package:fl_booking_app/screens/booking/services_tab/components/service_container.dart';
import 'package:fl_booking_app/screens/booking/booking_bottom_sheet.dart';

//Main body of the page
class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ServicesTab> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          //navigation button
          Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 255, 221, 182),
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Consumer<BookingInfo>(
                        builder: (context, bookingInfo, _) {
                      return FilledButton(
                        onPressed:
                            bookingInfo.services.isEmpty ? null : widget.onNext,
                        style: FilledButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            minimumSize: const Size(80, 48)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Далее'), // <-- Text
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              // <-- Icon
                              Icons.arrow_forward_ios_rounded,
                              size: 24.0,
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SizedBox(
          height: screenheight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SafeArea(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: FilledButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ServicesAdd()),
                                            );
                                          },
                                          icon: const Icon(
                                            // <-- Icon
                                            Icons.add_rounded,
                                            size: 20.0,
                                          ),
                                          label: const Text('Add services'),
                                          style: FilledButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius: BorderRadius.only(
                                            //         bottomLeft: Radius.circular(16),
                                            //         bottomRight:
                                            //             Radius.circular(16))),

                                            backgroundColor: const Color.fromARGB(
                                                255, 3, 166, 166),
                                            textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Text(
                                      'Выбранные услуги:',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const ServicesChosen(),
                                    //ExpansionTileServices(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const ServicesBottomSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//list of services, chosen by the customer
class ServicesChosen extends StatefulWidget {
  const ServicesChosen({super.key});

  @override
  State<ServicesChosen> createState() => _ServicesChosenState();
}

class _ServicesChosenState extends State<ServicesChosen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingInfo>(
      builder: (context, booking, child) {
        if (booking.services.isEmpty == false) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: booking.services.length,
            itemBuilder: (context, index) {
              // print(booking.services.length);
              return ServiceContainer(service: booking.services[index]);
            },
          );
        } else {
          return const Text('Нет выбранных услуг');
        }
      },
    );
  }
}
