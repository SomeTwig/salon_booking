import 'package:flutter/material.dart';

class BookingInfo extends ChangeNotifier {
  String _date = '';
  String _time = '';
  String _salonName = '';
  List<String> _services = [''];
  // double _priceTotal = 0;
  String _clientName = '';
  String _clientPhone = '';
  String _clientComment = '';
  bool _personalPermit = false;

  String get bDate => _date;
  String get bTime => _time;
  String get sName => _salonName;
  List<String> get services => _services;
  String get clientName => _clientName;
  String get clientPhone => _clientPhone;
  String get clientComment => _clientComment;
  bool get personalPermit => _personalPermit;

  void addSalonName(String salName) {
    _salonName = salName;
    notifyListeners();
  }

  void addDateTime(String aDate, String aTime) {
    _date = aDate;
    _time = aTime;
  }

  void addServices(List<String> aServices) {
    _services.addAll(aServices);
  }

  void addClientInfo(String aClientName, String aClientPhone,
      String aClientComment, bool isPermitted) {
    _clientName = aClientName;
    _clientPhone = aClientPhone;
    _clientComment = aClientComment;
    _personalPermit = isPermitted;
  }
}
