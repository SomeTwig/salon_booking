import 'package:flutter/material.dart';
import 'package:test_1/models/service.dart';
import 'package:test_1/providers/services_provider.dart';

class BookingInfo extends ChangeNotifier {
  String _date = '';
  String _time = '';
  String _salonName = '';
  List<Service> _services = [];
  // double _priceTotal = 0;
  String _clientName = '';
  String _clientPhone = '';
  String _clientComment = '';
  bool _personalPermit = false;

  String get bDate => _date;
  String get bTime => _time;
  String get sName => _salonName;
  List<Service> get services => _services;
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

  void addServices(List<Service> aServices) {
    for (var service in aServices) {
      if (_services.indexWhere(
              (element) => element.serviceId == service.serviceId) ==
          -1) {
        _services.add(service);
      }
    }
    notifyListeners();
  }

  void addService(Service aService) {
    // for (var element in _services) {
    //   if (element.serviceId == aService.serviceId) {
    //     print(element.serviceName);
    //     return;
    //   }
    // }
    // if (_services.contains(aService) == false) {
    _services.add(aService);
    notifyListeners();
    // }
  }

  void deleteService(Service aService) {
    if (_services.contains(aService) == true) {
      _services.remove(aService);
      notifyListeners();
    }
  }

  void addClientInfo(String aClientName, String aClientPhone,
      String aClientComment, bool isPermitted) {
    _clientName = aClientName;
    _clientPhone = aClientPhone;
    _clientComment = aClientComment;
    _personalPermit = isPermitted;
  }
}
