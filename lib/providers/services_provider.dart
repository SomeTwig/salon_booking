import 'package:flutter/material.dart';
import 'package:test_1/models/service.dart';

class ServiceList with ChangeNotifier {
  List<Service> _services = [];

  List<Service> get services => _services;

  set services(List<Service> value) {
    _services = value;
  }

  void addService(Service aService) {
    for (var element in _services) {
      if (element.serviceId == aService.serviceId) {
        print(element.serviceName);
        return;
      }
    }
    _services.add(aService);
    notifyListeners();
  }

  void deleteService(Service aService) {
    if (_services.contains(aService) == true) {
      _services.remove(aService);
      notifyListeners();
    }
  }

  void deleteAllServices() {
    _services.clear();
  }
}
