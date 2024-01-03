import 'package:flutter/material.dart';

import 'package:fl_booking_app/routes/route.dart' as route;

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Главная"),
                    onTap: () {
                      Navigator.pushNamed(context, route.homePage);
                    }),
                //add more drawer menu here
              ],
            ))),
  );
}
