import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/models/models.dart';
import 'package:test_1/screens/booking/services_tab/services_add/services_add.dart';

import 'package:test_1/screens/booking/services_tab/services_add/components/services_expand.dart';
import 'package:test_1/data/data.dart';

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
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                              minimumSize: Size(50, 60),
                              maximumSize: Size(125, 80),
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
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: booking.services.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(booking.services[index].serviceName),
              );
            },
          );
        } else {
          return Text('Нет выбранных услуг');
        }
      },
    );
  }
}
