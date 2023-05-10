import 'package:flutter/material.dart';

// Define Routes
import 'package:test_1/screens/home/home.dart';
import 'package:test_1/screens/booking/booking.dart';
import 'package:test_1/screens/salons/salons.dart';
import 'package:test_1/models/models.dart';

const String homePage = 'home';
const String bookingPage = 'booking';
const String salonsPage = 'salons';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => MyHomePage());
    case bookingPage:
      return MaterialPageRoute(builder: (context) => BookingPage());
    case salonsPage:
      return MaterialPageRoute(builder: (context) => SalonsPage());
    default:
      throw ('This route name does not exit');
  }
}
