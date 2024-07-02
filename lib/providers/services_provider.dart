import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/flService.dart';
import 'package:fl_booking_app/constants/constants.dart';
import 'package:fl_booking_app/services/booking_service.dart';

class ServiceList with ChangeNotifier {
  final _bookingService = BookingService();
  ServiceStatus _status = ServiceStatus.none;

  //List<Service> _allServices = [];
  final List<FLService> _services = [];

  double _serviceSum = 0;

  ServiceStatus get status => _status;

  List<FLService> get services => _services;

  double get serviceSum => _serviceSum;

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
    aService.discountedPrice<aService.price ? addSum(aService.discountedPrice) : addSum(aService.price);
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
      aService.discountedPrice<aService.price ? subtractSum(aService.discountedPrice) : subtractSum(aService.price);
      // print(aService.serviceParamId);
      int qty = _services
          .firstWhere((element) => element.key == aService.key)
          .quantity--;
      qty--;
      //print(qty);
      if (qty <= 0) {
        _services.remove(aService);
      }
    }
    notifyListeners();
  }

  void deleteAllServices() {
    _services.clear();
    _serviceSum = 0;
  }

  void addSum(double aServicePrice) {
    _serviceSum += aServicePrice;
    notifyListeners();
  }

  void subtractSum(double aServicePrice) {
    _serviceSum -= aServicePrice;
    notifyListeners();
  }
}
