import 'package:flutter/material.dart';
import 'package:test_1/models/services_list_model.dart';

class BookingInfo extends ChangeNotifier {
  String _date = '';
  String _time = '';
  String _salonName = '';
  List<ServiceList> _services = [];
  // double _priceTotal = 0;
  String _clientName = '';
  String _clientPhone = '';
  String _clientComment = '';
  bool _personalPermit = false;

  String get bDate => _date;
  String get bTime => _time;
  String get sName => _salonName;
  List<ServiceList> get services => _services;
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

  void addServices(List<ServiceList> aServices) {
    _services.addAll(aServices);
    
    notifyListeners();
  }

  void addService(ServiceList aService) {
    if(_services.contains(aService)==false){
      _services.add(aService);
    notifyListeners();}
  }

  void addClientInfo(String aClientName, String aClientPhone,
      String aClientComment, bool isPermitted) {
    _clientName = aClientName;
    _clientPhone = aClientPhone;
    _clientComment = aClientComment;
    _personalPermit = isPermitted;
  }
}
