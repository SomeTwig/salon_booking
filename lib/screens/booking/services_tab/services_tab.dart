import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/services_add.dart';

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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(157, 192, 158, 120),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        minimumSize: Size(100, 50)),
                    child: Row(
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 70),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Выбраный салон: \n${Provider.of<BookingInfo>(context, listen: false).sName}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ServicesAdd()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Добавить\n услугу'), // <-- Text
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
                      ServicesChosen(),
                      //ExpansionTileServices(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          return SafeArea(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: booking.services.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 2, left: 10),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 10,
                                      child: Text(
                                          booking.services[index].serviceName)),
                                  const Spacer(),
                                  // MaterialButton(
                                  //   color: myPrimaryColor,
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(20)),
                                  //   onPressed: () {
                                  //     Provider.of<BookingInfo>(context,
                                  //             listen: false)
                                  //         .deleteService(booking.services[index]);
                                  //   },
                                  //   child: const Text(
                                  //     'Удалить',
                                  //     style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w600),
                                  //   ),
                                  // ),
                                  _quantityControl(booking.services[index]),
                                ]))
                      ]));
                },
              ),
            ),
          );
        } else {
          return Text('Нет выбранных услуг');
        }
      },
    );
  }

  Widget _quantityControl(FLService aService) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _decrementButton(aService),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${aService.quantity}',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            width: 15,
          ),
          _incrementButton(aService),
        ],
      ),
    );
  }

  Widget _incrementButton(FLService aService) {
    return IconButton(
      onPressed: () {
        setState(() {
          Provider.of<BookingInfo>(context, listen: false).addService(aService);
        });
      },
      icon: Icon(Icons.add, color: Colors.black87),
    );
  }

  Widget _decrementButton(FLService aService) {
    return IconButton(
      onPressed: () {
        setState(() {
          Provider.of<BookingInfo>(context, listen: false)
              .deleteService(aService);
        });
      },
      icon: Icon(Icons.remove, color: Colors.black87),
    );
  }
}
