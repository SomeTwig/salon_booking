import 'package:flutter/material.dart';

// Define Routes
import 'package:fl_booking_app/screens/home/home.dart';
import 'package:fl_booking_app/screens/booking/booking.dart';
import 'package:fl_booking_app/screens/salons/salons.dart';

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
