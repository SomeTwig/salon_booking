import 'package:flutter/material.dart';

import 'package:fl_booking_app/routes/route.dart' as route;

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Главная"),
                    onTap: () {
                      Navigator.pushNamed(context, route.homePage);
                    }),

                ListTile(
                    leading: Icon(Icons.book),
                    title: Text("Бронировать"),
                    onTap: () {
                      Navigator.pushNamed(context, route.salonsPage);
                    }),
                //add more drawer menu here
              ],
            ))),
  );
}
