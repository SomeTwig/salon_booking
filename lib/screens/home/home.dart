import 'package:flutter/material.dart';

import '../../widgets/appdrawer.dart';
import '../../routes/route.dart' as route;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      drawer: myDrawer(context),
      body: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, route.salonsPage),
                  icon: Icon(Icons.add_circle),
                  label: Text('Бронировать'),
                ),
                SizedBox(width: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
