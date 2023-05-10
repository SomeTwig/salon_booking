import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/models/models.dart';

import 'package:test_1/screens/booking/services_tab/components/services_expand.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
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
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Выбраный салон: \n${Provider.of<BookingInfo>(context, listen: false).sName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Выберите желаемые услуги:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      // ListView.builder(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: flSalon.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return SalonContainer(
                      //       flSalon: flSalon[index],
                      //     );
                      //   },
                      // ),
                      ExpansionTileServices(),
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
