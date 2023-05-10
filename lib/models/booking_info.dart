import 'package:flutter/material.dart';

class BookingInfo extends ChangeNotifier {
  String date = '';
  String time = '';
  String salonName = '';
  // List<String> services = [''];
  // double priceTotal = 0;
  // String clientName = '';
  // String clientPhone = '';
  // String clientComment = '';
  // bool personalPermit = false;

  String get sName => salonName;
  String get bDate => date;
  String get bTime => time;

  void addSalonName(String salName) {
    salonName = salName;
    notifyListeners();
  }

  void addDateTime(String aDate, String aTime) {
    date = aDate;
    time = aTime;
  }
}
