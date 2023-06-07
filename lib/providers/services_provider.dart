import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/flService.dart';
import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/services/booking_service.dart';

class ServiceList with ChangeNotifier {
  final _bookingService = BookingService();
  ServiceStatus _status = ServiceStatus.none;

  //List<Service> _allServices = [];
  List<FLService> _services = [];
  ServiceStatus get status => _status;

  List<FLService> get services => _services;

  Future<List<FLService>> fetchAllServices() async {
    _status = ServiceStatus.loading;
    notifyListeners();

    try {
      final res = await _bookingService.fetchServices();
      //_allServices = res;

      _status = ServiceStatus.success;
      notifyListeners();

      return res;
    } catch (e) {
      print('fetchAllServices Error: $e');

      _status = ServiceStatus.failed;
      return [];
    }
  }

  void addService(FLService aService) {
    for (var element in _services) {
      if (element.key == aService.key) {
        element.quantity++;
        return;
      }
    }
    aService.quantity++;
    _services.add(aService);
    notifyListeners();
  }

  void deleteService(FLService aService) {
    if (_services.contains(aService) == true) {
      int qty = _services
          .firstWhere((element) => element.key == aService.key)
          .quantity--;
      if (qty == 0) {
        _services.remove(aService);
      }
      notifyListeners();
    }
  }

  void deleteAllServices() {
    _services.clear();
  }
}
