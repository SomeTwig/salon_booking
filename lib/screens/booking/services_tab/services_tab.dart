//one of the booking tabs, includes services already chosen by the customer
//and button to add new services (->services_add)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/services_add.dart';
import 'package:fl_booking_app/screens/booking/services_tab/components/service_container.dart';

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
        color: const Color.fromARGB(157, 192, 158, 120),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Consumer<BookingInfo>(builder: (context, bookingInfo, _) {
                      return ElevatedButton(
                        onPressed: bookingInfo.services.isEmpty ? null : widget.onNext, 
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            minimumSize: const Size(100, 50)),
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Выбраный салон: \n${Provider.of<BookingInfo>(context, listen: false).sName}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ServicesAdd()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Добавить\n услугу'), // <-- Text
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              // <-- Icon
                                              Icons.add_rounded,
                                              size: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  color: const Color.fromARGB(157, 192, 158, 120),
                  child: Row(
                    children: [
                      const Text(
                        'Сумма',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      Consumer<BookingInfo>(
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
                    ],
                  ),
                ),
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
