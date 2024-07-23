import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/route.dart' as route;

import 'models/locale.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/providers/providers.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BookingInfo()),
          ChangeNotifierProvider(create: (context) => ServiceList()),
          ChangeNotifierProvider(create: (context) => OfficeList()),
          ChangeNotifierProvider(create: (context) => MyAccount()),
        ],
        child: const MyApp(),
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
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp.router(
          routerConfig: route.goRouter,
          debugShowCheckedModeBanner: false,
          title: 'Salon Booking App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(
                255,
                217,
                176,
                126,
              ),
              secondary: const Color.fromARGB(255, 68, 95, 95),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 111, 247, 246),
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeModel.locale,
        ),
      ),
    );
  }
}
