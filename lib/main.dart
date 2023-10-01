import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/route.dart' as route;
import 'package:intl/date_symbol_data_local.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/providers/providers.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BookingInfo()),
          ChangeNotifierProvider(create: (context) => ServiceList()),
          ChangeNotifierProvider(create: (context) => OfficeList())
        ],
        child: MyApp(),
      ),
    ),
  );
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
