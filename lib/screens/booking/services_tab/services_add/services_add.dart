import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/models/models.dart';

import 'package:test_1/screens/booking/services_tab/services_add/components/services_expand.dart';
import 'package:test_1/data/data.dart';

class ServicesAdd extends StatefulWidget {
  const ServicesAdd({super.key});

  @override
  State<ServicesAdd> createState() => _ServicesAddState();
}

class _ServicesAddState extends State<ServicesAdd> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(157, 192, 158, 120),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      minimumSize: Size(100, 50)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Отменить'), // <-- Text
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        // <-- Icon
                        Icons.cancel_outlined,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      minimumSize: Size(100, 50)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Выбрать'), // <-- Text
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        // <-- Icon
                        Icons.check_circle_outline_rounded,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
                child: Column(children: [
              const SizedBox(
                height: 20,
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
                    children: [
                      const Text(
                        'Выберите услуги:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTileServices(),
                    ],
                  ),
                ),
              )
            ]))));
  }
}
