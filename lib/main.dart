import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'route/route.dart' as route;
import 'package:test_1/screens/home/home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_1/models/models.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(ChangeNotifierProvider(
        create: (context) => BookingInfo(),
        child: MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: route.controller,
      initialRoute: route.homePage,
      debugShowCheckedModeBanner: false,
      title: 'Salon Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
    );
  }
}
